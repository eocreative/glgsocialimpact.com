module.exports = function(grunt) {

  // Load S3 plugin
  grunt.loadNpmTasks('grunt-aws');

  // Static Webserver
  grunt.loadNpmTasks('grunt-contrib-connect');

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    aws: grunt.file.readJSON('.aws.json'),
    s3: {
      options: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
        bucket: process.env.AWS_REGION,
        region: process.env.AWS_HOSTNAME
      },
      build: {
        cwd: "public",
        src: "**"
      }
    },
    connect: {
      server: {
        options: {
          port: 8000,
          base: "public",
          keepalive: true
        }
      }
    }
  });

  // Default task(s).
  grunt.registerTask("default", ["connect"]);

};