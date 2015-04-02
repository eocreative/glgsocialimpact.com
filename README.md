#GLG SOCIAL IMPACT

####A super static website autodeployed from Starphleet Jobs to an S3 bucket.

Run 'Grunt serve' to serve on localhost and it will watch all template file changes in the src folder
 - If you're making template changes, do it to the ejs files in the src folder, otherwise work out of public folder.

Run 'Grunt S3' to push site live to the S3 bucket (make sure you have your environmental variables set)

Uses 'Form Mailer' to send emails (https://github.com/glg/form-mailer)