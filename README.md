# bush - build w/ shell

simple program that evaluates `{{}}` sorrounded shell scripts in the files of the `src` directory, outputting them in the `dist` directory. this is specially useful when making a static website. see [the example.html file](./src/example.html) for reference.

hidden files are executed as scripts, from the project root. the template function is available, like shown from the [.build file](./src/.build).

use `./build.sh` or `make` to try it.
