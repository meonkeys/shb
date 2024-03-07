# Pelican test

## Usage

`build.sh` builds and runs Pelican in a container via Bash and `website/Makefile`.

Example commands:

```bash
# serve to http://localhost:8000 and watch files for changes
./build.sh make devserver-global

# generate HTML to website/output
./build.sh make html

# show all commands
./build.sh make help
```

## See also

* https://docs.getpelican.com/en/latest/
* https://pypi.org/project/Jinja2/
* https://realpython.com/primer-on-jinja-templating/
* https://jinja.palletsprojects.com/en/3.1.x/api/#basics
* https://stackoverflow.com/questions/69979846/how-to-run-a-venv-in-the-docker
