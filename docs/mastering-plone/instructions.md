---
myst:
  html_meta:
    "description": "How to install Plone 6 for the training"
    "property=og:description": "How to install Plone 6 for the training"
    "property=og:title": ""
    "keywords": "Installation and Setup of Plone 6 for the training 'Mastering Plone Development'"
---

(instructions-label)=

# Set up Plone for the Training

We install the `Plone` backend and its `React`-based frontend `Volto`, starting with the following folder structure:

```text
training
├── backend
└── frontend
```

In {file}`backend` we install Plone and add our custom Python code.
In {file}`frontend` we install Volto and add our custom React code.


(instructions-install-backend-label)=

## Installing the backend

We encourage you to install and run `Plone` on your own machine, as you will have important benefits:

- You can work with your favorite editor.
- You have all the code of Plone at your fingertips in `site-packages` tree.


### Prerequisites

- `make`. We recommend upgrading to at least make 4. 


### Installation

Set up the [backend with the training code](https://github.com/collective/training_buildout): add-ons `ploneconf.site`  and `training.votable`.

```shell
mkdir training
cd training
git clone https://github.com/collective/training_buildout.git backend
cd backend
```

Build your backend with:

```shell
make build
```

This build executes multiple tasks.
The build
- creates a Python virtual environment and installs prerequisites
- generates a file structure to be prepared to install Plone packages with pip
- generates Zope configuration with cookiecutter

By creating and working with a **Python virtual environment**, we are independent of the system Python installation. We install packages and its version according to our needs.

The build generates a file structure to be prepared to install **Plone from packages** with `pip` and `mxdev`. The tool `mxdev` helps with configuration files to define which add-ons and which versions to install.
It also allows to override Plone core package versions or force a checkout from `github`.
The documentation {ref}`plone6docs:manage-plone-backend-packages-with-mxdev-label` provides information on common tasks.

The build generates **Zope configuration** files with cookiecutter `cookiecutter-zope-instance`.
The file we will modify to update our Zope / Plone configuration is `instance.yaml`.
In this file we will add add-ons that are installed as Python packages and shall be loaded in our instance.
`instance.yaml` is the one configuration file for our Zope / Plone instance.
The documentation of [`cookiecutter-zope-instance`](https://github.com/plone/cookiecutter-zope-instance) explains a lot more that can be configured like the port or another storage. 

After changes in configuration files, a re-build is necessary:

```shell
make build
```

We are now ready to start the backend with:

```shell
make start
```

Voilà, your Plone is up and running on http://localhost:8080.

The output should be similar to:

```shell
katjasuss@purpur training % make start

2022-09-27 08:57:23,961 INFO    [Zope:42][MainThread] Ready to handle requests
Starting server in PID 28745.
2022-09-27 08:57:23,963 INFO    [waitress:486][MainThread] Serving on http://[::1]:8080
2022-09-27 08:57:23,963 INFO    [waitress:486][MainThread] Serving on http://127.0.0.1:8080
```

Troubleshooting: We are here to help: Please file an issue in [training repo](https://github.com/plone/training/issues). 

Point your browser to <http://localhost:8080> to see `Plone` running.

```{figure} _static/instructions_plone_running.png
:alt: Plone is running.
:scale: 50 %

`Plone`, up and running.
```

There is no Plone site yet.
We will create one in the next chapter.

You can stop the running instance anytime using {kbd}`ctrl + c`.



```{figure} _static/instructions_create_instance.png
:alt: Ready to create a `Plone` instance.
:scale: 50 %

Ready to create a `Plone` instance
```





(instructions-install-frontend-label)=

## Installing the frontend

You have two options:

> 1. Create the frontend from scratch using the Volto generator.
> 2. Use the prepared Volto project [volto-ploneconf](https://github.com/collective/volto-ploneconf) with all the code for the training.


### Option 1: Frontend from scratch with Volto generator


{ref}`plone6docs:frontend-getting-started-installing-volto-label`


### Option 2. Start with prepared training project `volto-ploneconf` with all code for the training

Prepare the pre-requisites explained in {ref}`plone6docs:install-packages-prerequisites-label`.

Get the code for the frontend from GitHub and install:

```shell
git clone https://github.com/collective/volto-ploneconf.git frontend
cd frontend
yarn
```

Now you can start the app with:

```
$ yarn start
```

Create a Plone site object *Plone* on <http://localhost:8080>

Point your browser to <http://localhost:3000> and see that Plone is up and running.

You can stop the frontend anytime using {kbd}`ctrl + c`.
