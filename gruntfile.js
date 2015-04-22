module.exports = function(grunt) {

  // Load S3 plugin
  grunt.loadNpmTasks('grunt-aws');

  // Static Webserver
  grunt.loadNpmTasks('grunt-contrib-connect');

  // Use for templating
  grunt.loadNpmTasks('grunt-ejs');

  // For CSS compilation
  grunt.loadNpmTasks('grunt-contrib-sass');

  // Watch for changes in project and re-render
  grunt.loadNpmTasks('grunt-contrib-watch');

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    s3: {
      options: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
        bucket: process.env.AWS_BUCKET,
        region: process.env.AWS_REGION
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
        }
      }
    },
    ejs: {
      all: {
        cwd: 'src',
        src: ['*.ejs', 'fellows/*.ejs', '!partials/**/*'],
        dest: 'public/',
        expand: true,
        ext: '.html'
      }
    },
    sass: {                              // Task
      dist: {                            // Target
        options: {                       // Target options
          style: 'expanded',
          sourcemap: 'none'
        },
        files: [{
          expand: true,
          cwd: 'src',
          src: ['css/main.scss'],
          dest: 'public/',
          ext: '.css'
        }]
      }
    },
    watch: {
      scripts: {
        files: ['src/*.ejs','src/fellows/*.ejs', 'src/partials/*.ejs'],
        tasks: ['ejs'],
        options: {
          livereload: true
        }
      },
      css: {
        files: ['src/css/*.scss','src/css/bootstrap/*.scss', 'src/css/font-awesome/font-awesome.scss'],
        tasks: ['sass'],
        options: {
          livereload: true,
        },
      }
    }
  });


  // Default task(s).
  grunt.registerTask("default", ["connect"]);

  grunt.registerTask("serve", ["connect", "watch"]);

};