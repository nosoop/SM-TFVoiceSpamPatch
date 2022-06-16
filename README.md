# TF2 Voice Spam Patch

[:coffee: fund my caffeine addiction :coffee:](https://buymeacoff.ee/nosoop)

Patches the game to provide unlimited, fully unthrottled voice spam, only when
`tf_max_voice_speak_delay` is a negative value.

This plugin exists to address [the known limitation of 3.33 voice commands per second][vcl] that
sigsegv-mvm's unlimiter runs into.

[vcl]: https://github.com/sigsegv-mvm/TFMaxVoiceSpeakDelayUnlimiter#known-issues

## Installation

Requires the following:

- [DHooks with detour support][dynhooks] (if you're running SourceMod 1.11, it comes bundled;
you do not need to install this separately)
- [Source Scramble][] (you only need the extension for this, not the manager)

Install [the latest packaged release][release] by copying `gamedata/tf2.voice_spam_fix.txt` and
`plugins/tf_enable_voice_spam.smx` to the appropriate spot on your server.

[dynhooks]: https://github.com/peace-maker/DHooks2/
[Source Scramble]: https://github.com/nosoop/SMExt-SourceScramble
[release]: https://github.com/nosoop/SM-TFVoiceSpamPatch/releases

## Building

This project is configured for building via [Ninja][]; see `BUILD.md` for detailed
instructions on how to build it.

If you'd like to use the build system for your own projects,
[the template is available here](https://github.com/nosoop/NinjaBuild-SMPlugin).

[Ninja]: https://ninja-build.org/
