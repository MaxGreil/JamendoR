
JamendoR
========

<!-- README.md is generated from README.Rmd. Please edit that file -->
Overview
--------

JamendoR is an R wrapper for pulling track audio features and other information from Jamendo's Web API. You can pull song and playlist information for a given Jamendo User (including yourself!) or enter an artist's -, album's -, or tracks's name and retrieve the available information in seconds.

Installation
------------

Development version

``` r
devtools::install_github('MaxGreil/JamendoR')
```

Authentication
--------------

First, set up an account with Jamendo to access their Web API [here](https://devportal.jamendo.com/signup). This will give you your `Client ID` and `Client Secret`. Once you have those, you can pull your access token into R with `jamendoOAuth(app_name)`.

The easiest way to authenticate is to set your credentials to the System Environment variables `JAMENDO_CLIENT_ID` and `JAMENDO_CLIENT_SECRET`. The default arguments to `jamendoOAuth(app_name)` (and all other functions in this package) will refer to those. Alternatively, you can set them manually and make sure to explicitly refer to your access token in each subsequent function call.

``` r
Sys.setenv(JAMENDO_CLIENT_ID = 'xxxxxxxxxxxxxxxxxxxxx')
Sys.setenv(JAMENDO_CLIENT_SECRET = 'xxxxxxxxxxxxxxxxxxxxx')

my_oauth <- jamendoOAuth(app_name="xxxx")
```

#### Authorization code flow

For certain functions and applications, you'll need to log in as a Jamendo user. To do this, your Jamendo application needs to have a callback url. You can set this to whatever you want that will work with your application, but a good default option is `http://localhost:1410/` (see image below). For more information on authorization, visit the offical [Jamendo Developer Guide](https://developer.jamendo.com/v3.0/authentication).

<img src="man/figures/JamendoR_auth_screenshot.png" width="50%" />

Usage
-----
