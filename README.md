# yum-cron Cookbook

![Travis Button](https://travis-ci.org/osuosl-cookbooks/yum-cron.svg)

The yum-cron cookbook takes over management of the `yum-cron` package and
service. This provides an automatic way to upgrade any yum based operating
system.

## Supported Platforms

* CentOS 6.6
* CentOS 7.0

## Attributes

Please consult the attributes file for the most up to date attribute settings
and read the `yum-cron` man page for more details.

## Recipes

### yum-cron::default

Include `yum-cron` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[yum-cron::default]"
  ]
}
```

## License and Authors

- Author:: Oregon State University (<chef@osuosl.org>)

```text
Copyright:: 2015 Oregon State University

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
