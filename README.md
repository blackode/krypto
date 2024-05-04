# Welcome Krypto CoinPair Average Calculator

![Project Out Line Image](krypto.png)


## Project Highlighted Module

### Kyrpto.CoinPair

This module simulates a Persistent Server for subscribing the coinpair and storing the prices of coinpair using `GenServer`

It will start as soon as our `krypto` app starts.

## Development Technologies

At the moment of developing this project, I used the following versions of
Elixir and Erlang.

```elixir
iex> mix hex.info

Hex:    2.0.6
Elixir: 1.16.1
OTP:    26.2.2

Built with: Elixir 1.16.1 and OTP 24.3.4.16

```
# Running Application

## 2.1) mix release vhs

```
mix deps.get
mix release vhs
```

I added the releases path to `./releases` 

So, we are provided with following commands.

```
Release created at releases!

    # To start your system
    releases/bin/vhs start

Once the release is running:

    # To connect to it remotely
    releases/bin/vhs remote

    # To stop it gracefully (you may also send SIGINT/SIGTERM)
    releases/bin/vhs stop

To list all commands:

    releases/bin/vhs

```

visit `localhost:4000/blocknative/transactions/pending` 



#### 2.2) iex -S mix

Running Interactively



# Receiving Transaction Updates as Webhooks

## Expose a local web server to the internet

The `ngrok` will allow local webserver running to internet. So, we can use our local webserver url as webhook url at `blocknative`.

run the following command

```shell
ngrok http 4000
```

You will see the following output.

```
Session Status                online
Version                       2.3.40
Region                        United States (us)
Web Interface                 http://127.0.0.1:4040
Forwarding                    http://14fc-136-185-52-176.ngrok.io -> http://localhost:4000
Forwarding                    https://14fc-136-185-52-176.ngrok.io -> http://localhost:4000
Connections                   ttl     opn     rt1     rt5     p50     p90
```

The urls may look different as `ngrok` assigns random hexadecimal names to the HTTP tunnels it opens.  
Here the url is `http://14fc-136-185-52-176.ngrok.io` which will act our webhook base.

Make sure you add `http://14fc-136-185-52-176.ngrok.io/blocknative/webhook` as webhook url for `blocknative`.

## Project Challenges

- API Integration (Blocknative) Implementation
- Transaction Server callbacks for updating the transaction status.
- Using docker to releases with Elixir.

## TIL

- Learned how to use localhost web server as `webhook` using `ngrok`
- Docker setup for Elixir projects with releases

## Overall Project Experience

I felt it is a well framed to test core concepts of Elixir as project made me to code in all the core concepts of Elixir like `GenServers`, `Enumaration`, `collections`, `webhooks`.

## What I enjoyed?

I really enjoyed coding webhooks, playing with docker, and notifying over slack.

Thank You :)

Best Regards,
Ankanna


