# TF2 Voice Spam Patch

[:coffee: fund my caffeine addiction :coffee:](https://buymeacoff.ee/nosoop)

Patches the game to provide unlimited voice spam, only when `tf_max_voice_speak_delay` is a
negative value.

Requires the following:

- [DHooks with detour support][dynhooks] (if you're running SourceMod 1.11, it comes bundled;
you do not need to install this separately)
- [Source Scramble][]

[dynhooks]: https://github.com/peace-maker/DHooks2/
[Source Scramble]: https://github.com/nosoop/SMExt-SourceScramble

## Building

This project is configured for building via [Ninja][]; see `BUILD.md` for detailed
instructions on how to build it.

If you'd like to use the build system for your own projects,
[the template is available here](https://github.com/nosoop/NinjaBuild-SMPlugin).

[Ninja]: https://ninja-build.org/