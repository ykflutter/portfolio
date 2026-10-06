Drop screenshots here, numbered, PNG or JPG:

  task-assistant/1.png   2.png   3.png
  loan-origination/1.png 2.png   3.png
  otc-desk/1.png         2.png
  geo-service/1.png      2.png   3.png

Then list them in lib/data/content/projects_data.dart:

  screenshots: [
    'assets/images/projects/task-assistant/1.png',
    'assets/images/projects/task-assistant/2.png',
  ],

Shoot them at device resolution (a simulator screenshot is fine). They are
rendered inside a 19.5:9 phone frame, so a standard portrait screenshot fits
without cropping.
