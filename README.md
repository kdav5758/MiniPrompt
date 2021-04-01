<p align="center">
    <img
        width="360"
        src="https://i.imgur.com/bGS5btG.png"
        alt="MiniPrompt, a simple yet function rich bash prompt!"
    />
</p>

<p align="center">
    <a href="https://github.com/kdav5758/MiniPrompt"
        ><img
            src="https://img.shields.io/github/repo-size/kdav5758/MiniPrompt"
            alt="GitHub repository size"
    /></a>
    <a href="https://github.com/kdav5758/MiniPrompt/issues"
        ><img
            src="https://img.shields.io/github/issues/kdav5758/MiniPrompt"
            alt="Issues"
    /></a>
    <a href="https://github.com/kdav5758/MiniPrompt/blob/main/LICENSE"
        ><img
            src="https://img.shields.io/badge/license-GPL-blue"
            alt="GPL License"
    /></a>
    <a href="https://github.com/kdav5758/MiniPrompt/releases"
        ><img
            src="https://img.shields.io/github/downloads/kdav5758/MiniPrompt/total"
            alt="Amount of downloads"/></a
    ><br />
    <a href="https://github.com/kdav5758/MiniPrompt/releases"
        ><img
            src="https://img.shields.io/github/v/release/kdav5758/MiniPrompt"
            alt="Latest release"
    /></a>
    <a href="https://github.com/kdav5758/MiniPrompt/tree/dev"
            ><img
            src="https://img.shields.io/github/last-commit/kdav5758/MiniPrompt/dev"
            alt="Latest commit on dev branch"
    /></a>
    <a href="https://github.com/kdav5758/MiniPrompt/stargazers"
        ><img
            src="https://img.shields.io/github/stars/kdav5758/MiniPrompt"
            alt="Repository's starts"
    /></a>
</p>

<p align="center">
  <a href="#-features">Features</a>
  ·
  <a href="#-configuration">Configuration</a>
  ·
  <a href="#-install-and-setup">Installation</a>
</p>

<img
  src="https://i.imgur.com/0MOao4K.gif"
  alt="MiniPrompt with Kitty Terminal and a custom theme"
  width="55%"
  align="right"
  style="border-radius:2%"
/>

<div style="text-align: justify">

**Minimalist Prompt**, a decluttered and lightning fast, yet, *feature rich*, bash prompt!

- **Fast:** *less* stuff = *more* speed!
- **Customizable:** all the configuration variables are in two single file.
- **Feature-rich:** regardless of being a "bare bones prompt", has everything that's needed.
- **Easy:** quick installation and configuration.

</div>

## 🌲 Table of Contents

* [Features](#-features)
* [Installation and Setup](#-install-and-setup)
    * [Prerequisites](#prerequisites)
    * [Download](#download)
        * [Method #1 Stable release](#method-1---stable-release-recommended)
        * [Method #2 Unreleased-Test](#method-2---unreleased-test)
    * [Setup](#setup)
* [Configuration](#-configuration)
    * [Annotations](#annotations)
* [Inspirations](#☁%EF%B8%8F-inspirations)
* [FAQ](#-faq)
* [Reporting Issues](#⚠%EF%B8%8F-reporting-issues)

## 📋 Features

<details>
    <summary>Supports extensions!</summary>
    <br />
    <div style="text-align: justify">
        By definition, an extension is "a part that is added to something to enlarge or prolong it." In this context, these are added to prompt for showing extra information that might be relevant to the user, currently it supports the following ones:
    </div>
    <br />
    <details>
        <summary>Current git branch on prompt</summary>
        <br />
        <div style="text-align: justify">
            It shows the current git branch only if the user is inside a git repository.
        </div>
        <br />
        <br />
        <p align="center">
            <img
            src="https://i.imgur.com/hqUUcgB.gif"
            alt="Git branch on prompt"
            width="70%"
            />
            <p align="center">
                Git branch on prompt
            </p>
        </p>
    </details>
    <details>
        <summary>Changes prompt while being connected through ssh</summary>
        <br />
        <div style="text-align: justify">
            It simply changes the prompt according to whether the user is ssh-ing into somewhere.
        </div>
        <br />
        <br />
        <p align="center">
            <img
            src="https://i.imgur.com/JVcfDbu.gif"
            alt="SSH prompt"
            width="70%"
            />
            <p align="center">
                SSH prompt
            </p>
        </p>
    </details>
    <details>
        <summary>Current Kubernetes container</summary>
        <br />
        <div style="text-align: justify">
            It shows the current Kubernetes container.
        </div>
        <br />
        <br />
        <p align="center">
            <img
            src="https://i.imgur.com/zUHvERF.png"
            alt="Kubernetes container on prompt"
            width="70%"
            />
            <p align="center">
                Kubernetes container on prompt
            </p>
        </p>
    </details>
    <br />
</details>


<details>
    <summary>You can customize prompt's functions On Da Fly (w/ on_da_fly.sh)</summary>
    <br />
    <div style="text-align: justify">
        This is a companion for the prompt itself. The prompt is, of course, not dependent to this file, however it's a handy dandy script to have. This script allows you modify many of the prompts functions and specs from the command line with some simple commands for the current terminal session. The following are the commands:
    </div>
<p>

```
$ odf --help

This script simplifies the process of changing MiniPrompt's configuration variables
on the fly for the current terminal session

Usage:
    #0: ${this_scrpt} [arg] <modifier(s)>
    #1: ${this_scrpt} [flag]
Arguments:
    ex, exe,extensions,extensions_main              Modify 'extensions_main' var
    et, extr,extr,extras,extras_enabled             Modify 'extras_enabled' var
    hi, hist,history,history_enabled                Modify 'history_enabled' var
    dc, dirc,dircolors,dircolors_enabled            Modify 'dircolors_enabled' var
    gp, git,git_prompt,GIT_PROMPT                   Modify 'GIT_PROMPT' var
    kp, kube,kubernetes_prompt,KUBE_PROMPT          Modify 'KUBE_PROMPT' var
    sp, ssh,ssh_prompt,SSH_PROMPT                   Modify 'SSH_PROMPT' var
    ae, add_exit,ADD_EXIT                           Modify 'add_exit' var
    si, skip_init,SKIP_INIT                         Modify 'skip_init' var
Modifiers: (only for arguments)
    f/false/FALSE                                   Disables [arg]
    t/true/TRUE                                     Enables [arg]
Flags:
    -h,--help                                       See this help message.
    -d, -dis,-disable,-DISABLE                      Disable MiniPrompt

Examples:
    #0: $this_scrpt gp t
        Explanation: This will export the 'GIT_PROMPT' variable as true (enables it to show branch on prompt)
    #1: $this_scrpt ex f
        Explanation: This will export the 'extensions_main' variable as false (disables all extensions)
    #2: $this_scrpt ae t
        Explanation: This will export the 'add_exit' variable as true (enables exit status to be shown on prompt)

```
</p>
    <br />
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/0MOao4K.gif"
        alt="Example: dding git branch and customizing exit status"
        width="70%"
        />
        <p align="center">
            Example: adding git branch and customizing exit status
        </p>
    </p>
</details>

<details>
    <summary>Changes Directory colors!</summary>
    <br />
    <div style="text-align: justify">
        It guarantees that the directories are always colorized regardless of which command you are using to list the files in x dir (e.g. ls, exa.)
    </div>
    <br />
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/zUHvERF.png"
        alt="Blue dirs"
        width="70%"
        />
        <p align="center">
            Blue dirs
        </p>
    </p>
</details>

<details>
    <summary>Renames tab/win to current dir</summary>
    <br />
    <div style="text-align: justify">
        Renames the current tab/window accordingly to your current directory, of course, triming $HOME and replacing it with '~' if located at \$HOME or any inner dir.
    </div>
    <br />
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/hdlD7rH.png"
        alt="Renamed tabs"
        width="70%"
        />
        <p align="center">
            Renamed tabs/win
        </p>
    </p>
</details>

<details>
    <summary>Improves bash's default autocompletion</summary>
    <br />
    <div style="text-align: justify">
        Mainly, it removes case sensitiveness, therefore, typing "cmd" and then pressing <tab>, for intance, will get you the same output as if you where doing the same but wiht "CMD". Furthermore, it also colors output according to how close the match is to the word/command you are typing. By lexical comparison, it will highlight the matched part with purple, if the other part is predictibly matchable, it will highlight it in green, but if the other part of the is not quite so similar, it will highlight it with blue.
    </div>
    <br />
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/LcemeHw.gif"
        alt="Improved autocompletion"
        width="70%"
        />
        <p align="center">
            Improved autocompletion
        </p>
    </p>
</details>


<details>
    <summary>Displays last command's exit status</summary>
    <br />
    <div style="text-align: justify">
        Changes the prompt's last char color and/or symbol (according to user's specifications) respecting to the las command's exit status. If it was 0, then prompt will display the 'succes_symbol' in a green color, but if it's something other than that, it will display the 'error_symbol' in a red color (both by default).
    </div>
    <br />
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/6GAjKij.gif"
        alt="Exit status affects prompt"
        width="70%"
        />
        <p align="center">
            Exit status affects prompt
        </p>
    </p>
</details>

<details>
    <summary>Modifies history in order to show more information</summary>
    <br />
    <div style="text-align: justify">
        What this does it that it appends a formatted version of the date and the time at which *x* command was executed.
    </div>
    <br />
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/4n8vnh1.gif"
        alt="Custom history"
        width="70%"
        />
        <p align="center">
            Custom history
        </p>
    </p>
</details>

## 📦 Install and Setup

### Prerequisites

- [Bash 4.4+](https://www.gnu.org/software/bash/) (See [this manual](https://www.gnu.org/software/bash/manual/html_node/Installing-Bash.html) for the installation process.)
- A [Nerd Font](https://www.nerdfonts.com/) installed and enabled in the terminal (e.g. [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)) (Refer to [this](https://www.youtube.com/watch?v=fR4ThXzhQYI) explanation video on how to install one.)

### Download
MiniPrompt can be downloaded in two different forms:
1. Stable: Going to the [realses page](https://github.com/kdav5758/MiniPrompt/releases) of the repository and downloading the .zip file.
2. Testing: Cloning the repository from the `dev` branch to get latest and yet to be released features.
    1. Manually
    2. Using the `install.sh` script

#### Method #1 - Stable release (recommended)
<details>
    <summary>GUI Method (recommended)</summary>
    <br />
    <div style="text-align: justify">
        Simply download the latest tag's .zip file, unzip it, and put it into /usr/local/bin/
    </div>
    <br />
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/TkIxrkg.png"
        alt="GUI Step #1"
        width="60%"
        />
        <p align="center">
            Step #1 - Download the .zip (preferibly to /tmp/)
        </p>
    </p>
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/a6YkJyb.png"
        alt="GUI Step #2"
        width="60%"
        />
        <p align="center">
            Step #2 - unzip
        </p>
    </p>
    <br />
    <p align="center">
        <img
        src="https://i.imgur.com/uz94dfQ.png"
        alt="Step #3"
        width="60%"
        />
        <p align="center">
            Step #3 - cut and paste MiniPrompt to /usr/local/bin
        </p>
    </p>
    <br />
</details>

<details>
    <summary>Terminal Method</summary>
    <br />
    <div style="text-align: justify">
        Copy and paste this commands to the terminal. (remember to replace '<"tag_name">' with the tag name you want to download.)
    </div>
    <br />

<p>

```
$ cd /tmp/
$ wget https://github.com/kdav5758/MiniPrompt/archive/refs/tags/<tag_name>.zip # e.g. https://github.com/kdav5758/MiniPrompt/archive/refs/tags/v0.1.5.zip
$ unzip *.zip
$ sudo chmod 775 /usr/local/bin
$ sudo mv /tmp/MiniPrompt* /usr/local/bin/
$ cd /usr/local/bin/MiniPrompt*
```
</p>
    <br />
</details>


#### Method #2 - Unreleased test


<details>
    <summary>Manually (recommended)</summary>
    <br />
    <div style="text-align: justify">
        Copy and paste this commands to the terminal.
    </div>

<p>

```bash
$ sudo chmod 775 /usr/local/bin
$ cd /usr/local/bin/
$ git clone https://github.com/kdav5758/.dotfiles/tree/dev
$ sudo chmod 775 /usr/local/bin/MiniPrompt/mini_prompt.sh; sudo chmod 775 /usr/local/bin/MiniPrompt/scripts/on_da_fly.sh
```
</p>
    <br />
</details>

<details>
    <summary>With the install.sh script</summary>
    <br />
    <div style="text-align: justify">
        Copy and paste this commands to the terminal and let the script do its thing!
    </div>
    <br />

<p>

```bash
$ wget --output-document=/tmp/install.sh https://github.com/kdav5758/MiniPrompt/blob/dev/scripts/install.sh
$ sudo chmod 775 /tmp/install.sh
$ bash /tmp/install.sh
```
</p>
    <br />
</details>

---

### Setup
Now that you have MiniPrompt downloaded with the appropriate execution permissions, you'll have to configure it on your `.bashrc` file, usually located at `$HOME`. You should copy and paste the contents of the [.bashrc file located in the repo](https://github.com/kdav5758/MiniPrompt/blob/main/scripts/.bashrc) to `~/.bashrc` (or wherever it's located at). However, you can also use this commands:

```bash
$ cd /tmp/
$ wget https://raw.githubusercontent.com/kdav5758/MiniPrompt/main/scripts/.bashrc
$ cat .bashrc >> ~/.bashrc
```

(If `~/.bashrc` doesn't work, try `~/.bash_profile`.)

## 🍉 Configuration
The configuration is splitted into two parts:
1. At the top of [mini_prompt.sh](https://github.com/kdav5758/MiniPrompt/blob/main/mini_prompt.sh)
2. At the top of [extras.sh](https://github.com/kdav5758/MiniPrompt/blob/main/scripts/extras.sh)

On the first hand, `mini_prompt.sh` contains the "main" configuration such as prompt's symbols, main methods, extensions, etc. These are are the defaults:

```bash
# prompt symbols
success_symbol="λ"
error_symbol="✗"
git_branch_icon=""
kube_icon=""

# other
reset="\[\e[m\]"
this="$(basename "${BASH_SOURCE[0]}")"
skip_init=false
usr_content="[\[\e[3;33m\]\w\[\e[0m\]]\[\e[1;32m\]"

# main functionalities
add_exit=true

# extras
# extras are configured from `/usr/local/bin/scripts/extras.sh`
# they can all be enabled or disabled with this variable
export extras_enabled=true
# history
# dir colors

# extensions
extensions_main=false
GIT_PROMPT=true
SSH_PROMPT=false
KUBE_PROMPT=false
```

On the other hand, `extras.sh` contains the "secondary" configuration regarding stuff that is normally "out of the scope" of what a normal prompt should do, in this case, modifying both the history and the directory's colors. These are the defaults:

```bash
this="$(basename "${BASH_SOURCE[0]}")"
history_enabled=true
dircolors_enabled=true
```

As you can see, by default everything but `add_exit` and `extras` are turned off. The idea behind this is that the user should only use what is needed relative to the current session ([refer to the on_da_fly.sh feature](#-features)).

---

### Annotations
- If `$extensions_main` is set to false, it won't even check if the other extensions (e.g. `$GIT_PROMPT`) are set to true, this is so that the prompt can be `lightning fast`!
- `$usr_content` is where you will specify the contents of the prompt.
- Below `#prompt symbols` you will find the symbols that the prompt takes according to the current event.
- If `$prompt_init` is set to false, MiniPrompt won't be initialized.
- If `$extras_enabled` is set to false, the `extras.sh` file won't be initialized.

## ☁️ Inspirations
The following ones are the projects that inspired the creating of MiniPrompt. If possible go check them out to see why they are so amazing ;)
- [aelindeman/xelabash](https://github.com/aelindeman/xelabash): Bash prompt with minimal functions.
- [starship/starship](https://github.com/starship/starship): Customizable cross-shell prompt.
- [agkozak/polyglot](https://github.com/agkozak/polyglot): ASCII-only cross-shell git prompt.

## 🙋 FAQ
- ***Why doesn't it look like in the [Demo](https://i.imgur.com/0MOao4K.gif)?***

There two possible explanations for this:
1. You changed the `$usr_prompt` variable to something else, causing a different look in the prompt.
2. In the demo, the [Kitty terminal](https://github.com/kovidgoyal/kitty) was used with a custom theme inspired by the [Espresso theme](https://github.com/dexpota/kitty-themes#espresso) provided at the [Kitty Themes repository](https://github.com/dexpota/kitty-themes).

- ***Why can't I copy the files to `/usr/local/bin`?***

By default, you aren't allowed to place files here, so you must give yourself permissions:

```bash
$ sudo chmod 775 /usr/local/bin/
```

If this fails, try with `/usr/bin/`, **BUT be careful**, because here are stored most of your programs' binaries.

- ***Can I make it even faster?***

HELL YEAH! There are some simple things you can do:

- Install a GPU accelerated terminal, like [Kitty Terminal](https://github.com/kovidgoyal/kitty) or [Alacritty](https://github.com/alacritty/alacritty).
- Remove the original `$PS1` from your `~.bashrc` file. In most cases, you'll be looking for something like this:

```bash
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1="\[\033[01;32m\]\w\[\033[00m\]\[\033[01;39m\] >\[\033[00m\] "
fi
unset color_prompt force_color_prompt
```

## ⚠️ Reporting Issues
Issues are used to track todos, bugs, feature requests, and more, in this case this project has no special way for making issues, thus you can simply go to the [Issues section](https://github.com/kdav5758/MiniPrompt/issues).


