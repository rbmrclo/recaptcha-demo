# recaptcha-demo

[reCAPTCHA](https://www.google.com/recaptcha) is a free service that protects your website from spam and abuse. reCAPTCHA uses an advanced risk analysis engine and adaptive CAPTCHAs to keep automated software from engaging in abusive activities on your site. It does this while letting your valid users pass through with ease.

This is the ruby code counterpart of [recaptcha-codelab demo](https://github.com/googlecodelabs/recaptcha-codelab). If you want to see the python and java version, the google guys have created a simple demo for you.

## Pre-requisite

- Go to [the reCAPTCHA admin site](https://www.google.com/recaptcha/admin) to create an account.
- Choose **invisible recaptcha** as the type of captcha.

  ![img1](https://codelabs.developers.google.com/codelabs/reCAPTCHA/img/8ac38ee906f6b286.png)

- Fill in the list of domains you wish to show your captcha. For demo purposes,
  use `localhost` or your machine name. The reCAPTCHA site key you create will only work on these domains.

  ![img2](https://codelabs.developers.google.com/codelabs/reCAPTCHA/img/25ffcea502c8735.png)

- Copy the **site key** and change the dummy site key at `public/index.html`
- Copy the **secret key** and the change the dummy secret key at `server.rb`

## Setup

Clone the repo

```
$ git clone https://github.com/rbmrclo/recaptcha-demo.git
```

Install dependencies

```
$ bundle install
```

Run the server

```
$ ruby server.rb
```

You should be able to see a simple feedback page on http://localhost:9292
