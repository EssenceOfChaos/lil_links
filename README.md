# LilLinks

LilLinks is a blazing fast URL shortening service. It's written in Elixir with availability, scalability, and performance in mind. Progress is still ongoing with plans to add additional features to shortened links such as:

- expiration dates
- password protection
- high volume resiliency

To start the application, `git clone` to get a local copy. `cd lil_links` and run `mix.deps.get` to fetch the application dependencies. Next, start the application with `mix phx.server`. _(Note: an active instance of postgres will have to be running locally on the default port of `5432`.)_

Feel free to request a feature or submit a pull request.

Example POST request:

![Insomnia screenshot](https://github.com/EssenceOfChaos/lil_links/blob/master/assets/screenshots/example-post-req.png 'Example POST request')

Example GET request:

In the browser navigate to `http://localhost:4000/api/:hash`, where `:hash` is replaced with the hash received in the reponse of a POST request.

For example: while the application is running, navigating to `http://localhost:4000/api/6R2k1F` redirects to `https://elixircasts.io/json-api-with-phoenix-1.4`
