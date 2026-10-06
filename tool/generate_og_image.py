"""
Generates the social preview card (web/og-image.png, 1200x630).

This is what LinkedIn, WhatsApp, Slack and X show when someone shares your
link. Without it they render a blank grey box, which is the single most
common reason a shared portfolio link looks unfinished.

Re-run after changing your name or role:
    python3 tool/generate_og_image.py
"""

from PIL import Image, ImageDraw, ImageFont

W, H = 1200, 630

BG = (10, 10, 10)
INK = (245, 243, 239)
MUTED = (138, 148, 146)
HAIRLINE = (38, 38, 38)
ACCENT = (232, 224, 212)

NAME = "Yash Khade"
ROLE = "Flutter Developer  ·  Mobile Engineer"
TAGLINE = "I build cross-platform mobile apps that ship."
TECH = ["Flutter", "Dart", "Riverpod", "Bloc", "Firebase", "REST APIs"]
META = "4 YEARS  ·  FINTECH  ·  PRODUCTIVITY  ·  REAL-TIME"

FONT_DIR = "/usr/share/fonts/truetype/google-fonts"


def font(name, size):
    try:
        return ImageFont.truetype(f"{FONT_DIR}/{name}", size)
    except OSError:
        return ImageFont.load_default(size)


def main():
    img = Image.new("RGB", (W, H), BG)
    d = ImageDraw.Draw(img)

    pad = 84

    # Hairline frame — gives the card an edge so it reads as designed
    # rather than as a screenshot on a dark background.
    d.rectangle([pad - 32, pad - 32, W - pad + 32, H - pad + 32],
                outline=HAIRLINE, width=1)

    # Availability dot + label
    dot_y = pad + 6
    d.ellipse([pad, dot_y, pad + 11, dot_y + 11], fill=ACCENT)
    d.text((pad + 24, dot_y - 4), "OPEN TO OPPORTUNITIES",
           font=font("Poppins-Medium.ttf", 16), fill=MUTED)

    # Name
    d.text((pad, pad + 54), NAME,
           font=font("Poppins-Bold.ttf", 104), fill=INK)

    # Role
    d.text((pad, pad + 186), ROLE,
           font=font("Poppins-Medium.ttf", 28), fill=INK)

    # Tagline
    d.text((pad, pad + 238), TAGLINE,
           font=font("Poppins-Regular.ttf", 26), fill=MUTED)

    # Tech chips — fills the middle and tells a recruiter the stack
    # before they even open the link.
    chip_font = font("Poppins-Medium.ttf", 19)
    x = pad
    y = pad + 318

    for label in TECH:
        box = d.textbbox((0, 0), label, font=chip_font)
        w = box[2] - box[0]
        d.rounded_rectangle(
            [x, y, x + w + 36, y + 44], radius=6,
            outline=HAIRLINE, width=1,
        )
        d.text((x + 18, y + 9), label, font=chip_font, fill=MUTED)
        x += w + 36 + 12

    # Rule above the footer meta
    rule_y = H - pad - 52
    d.line([pad, rule_y, W - pad, rule_y], fill=HAIRLINE, width=1)

    d.text((pad, rule_y + 18), META,
           font=font("Poppins-Medium.ttf", 16), fill=MUTED)

    # Initials mark, bottom right
    mark = font("Poppins-Bold.ttf", 34)
    box = d.textbbox((0, 0), "YK", font=mark)
    d.text((W - pad - (box[2] - box[0]), rule_y + 12), "YK",
           font=mark, fill=INK)

    img.save("web/og-image.png", optimize=True)
    print(f"web/og-image.png  {W}x{H}")


if __name__ == "__main__":
    main()
