# r10k-agent

A [Choria/MCollective](https://choria.io) agent that invokes `r10k`
to deploy puppet environments on puppetservers.

This agent uses the [py-mco-agent](https://github.com/optiz0r/py-mco-agent) library to implement the choria external protocol.

# Requirements

* [r10k](https://github.com/puppetlabs/r10k)
* [py-mco-agent](https://github.com/optiz0r/py-mco-agent) `>=0.3.3`
* [choria](https://choria.io) `>=0.16.1`
* [python](https://www.python.org) `>=3.5`

# Installation

This project is packaged up as a puppet module and published to the forge as
`optiz0r-mcollective_agent_r10k`. The easiest way to use it is to add this module
to your `Puppetfile`:

```text
mod "optiz0r-mcollective_agent_r10k"
```

And `mcollective::plugin_classes` list in hiera:

```yaml
mcollective::plugin_classes:
  - mcollective_agent_r10k
```


# Usage

```shell script
choria req r10k deploy
```

```text
Discovering nodes using the mc method .... 1

1 / 1    0s [==============================================================] 100%

Finished processing 1 / 1 hosts in 5.68s
```

Or with JSON output for integration into other tools:
```shell script
choria req r10k deploy -j
```

```text
{
   "agent": "r10k",
   "action": "deploy",
   "replies": [
      {
         "sender": "whitefall.jellybean.sihnon.net",
         "statuscode": 0,
         "statusmsg": "",
         "data": {
            "stderr": "INFO\t -\u003e Using Puppetfile '/etc/puppetlabs/code/environments/development/Puppetfile'\nINFO\t -\u003e Using Puppetfile '/etc/puppetlabs/code/environments/production/Puppetfile'\n....",
            "stdout": ""
         }
      }
   ],
   "request_stats": {
      "requestid": "6fdaf77835b44990b13604a9f675eee0",
      "no_responses": [],
      "unexpected_responses": [],
      "discovered": 1,
      "failed": 0,
      "ok": 1,
      "responses": 1,
      "publish_time": 3136153,
      "request_time": 3520945109,
      "discover_time": 2000924298,
      "start_time_utc": "2021-11-30T23:10:05.310985002Z"
   },
   "summaries": {}
}
```
