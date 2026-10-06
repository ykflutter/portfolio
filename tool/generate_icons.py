"""
Generates the favicon and PWA icon set from the monochrome palette, so the
home-screen icon matches the app instead of the Flutter default.

    python3 tool/generate_icons.py

Writes into web/ and web/icons/.

Maskable icons keep the mark inside the central 80% safe zone, because
Android crops them to whatever shape the launcher uses.
"""

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

INK = "#F5F3EF"       # AppColors.darkInk
BACKGROUND = "#0A0A0A"  # AppColors.darkBackground
ACCENT = "#E8E0D4"    # AppColors.darkAccent

FONT = "/usr/share/fonts/truetype/google-fonts/Poppins-Bold.ttf"

WEB = Path(__file__).resolve().parent.parent / "web"
ICONS = WEB / "icons"


def _fitted_font(draw, text, target_width):
    """Largest size whose rendered width is <= target_width."""
    size = 8
    while size < 1000:
        font = ImageFont.truetype(FONT, size + 4)
        box = draw.textbbox((0, 0), text, font=font)
        if box[2] - box[0] > target_width:
            break
        size += 4
    return ImageFont.truetype(FONT, size)


def mark(size: int, safe: float = 1.0, rounded: bool = False) -> Image.Image:
    """`safe` shrinks the mark; 0.8 keeps it inside the maskable safe zone."""
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    if rounded:
        radius = int(size * 0.22)
        draw.rounded_rectangle([0, 0, size - 1, size - 1], radius,
                               fill=BACKGROUND)
    else:
        draw.rectangle([0, 0, size, size], fill=BACKGROUND)

    text = "YK"
    font = _fitted_font(draw, text, size * 0.56 * safe)
    box = draw.textbbox((0, 0), text, font=font)
    draw.text(
        ((size - (box[2] - box[0])) / 2 - box[0],
         (size - (box[3] - box[1])) / 2 - box[1]),
        text,
        font=font,
        fill=INK,
    )

    # A hairline under the mark, echoing the rules used across the site.
    rule_w = int(size * 0.26 * safe)
    rule_y = int(size * 0.76) if safe == 1.0 else int(size * 0.72)
    draw.rectangle(
        [(size - rule_w) // 2, rule_y, (size + rule_w) // 2,
         rule_y + max(1, size // 128)],
        fill=ACCENT,
    )
    return img


def main() -> None:
    ICONS.mkdir(parents=True, exist_ok=True)

    mark(512, rounded=True).save(WEB / "favicon.png")
    mark(192, rounded=True).save(ICONS / "Icon-192.png")
    mark(512, rounded=True).save(ICONS / "Icon-512.png")
    mark(192, safe=0.8).save(ICONS / "Icon-maskable-192.png")
    mark(512, safe=0.8).save(ICONS / "Icon-maskable-512.png")

    print("wrote favicon.png and 4 icons")


if __name__ == "__main__":
    main()
