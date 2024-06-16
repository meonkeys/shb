# mario system provisioner

Your software companion for the book _Steadfast Self-Hosting: Rapid-Rise Personal Cloud_.

## Prerequisites

* [Bash](https://www.gnu.org/software/bash/) version 5 or later
* [Ansible](https://www.ansible.com/) core at least the `minimumAnsibleCoreVersion` value in `ansible/provision.sh`
* decent/recent versions of GNU `grep`, `sed`, `sort`, and `head`

## Quick start

1. `cd ansible`
1. `./provision.sh`
1. Follow prompts.

Check out the mario chapter in the book for further instructions.

## Copyright and license

Copyright ©2023-2024 [Adam Monsen](https://adammonsen.com)

[GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.html) as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. See `COPYING`.

## Fix for `six.moves` module error on 22.04

If your admin computer is Ubuntu 22.04 LTS you may see `ModuleNotFoundError: No module named 'ansible.module_utils.six.moves'`. The root cause may be [this issue](https://github.com/ansible/ansible/issues/81946). If so, the fix is to add the [ansible PPA](https://launchpad.net/~ansible/+archive/ubuntu/ansible) and install the `ansible-core` package.

## Fix for missing `ufw` on 22.04

If your admin computer is Ubuntu 22.04 LTS and you get an error that the `ufw` module is missing, make sure the `ansible` package is installed.

## Fix for US/Pacific timezone error

If `timedatectl set-timezone` fails during `provision.sh`, you may be using an invalid timezone. I've specifically seen `US/Pacific` fail. If that's your timezone, use `America/Los_Angeles` instead. I believe these timezone names recently.
