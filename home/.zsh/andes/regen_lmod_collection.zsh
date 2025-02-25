# ~/.zsh/andes/regen_lmod_collection.zsh
# this file should be sourced, so the module command is available

# restore the default system modules
module --no_redirect restore
# development tools
module --no_redirect load vim git htop imagemagick

# This needs to be saved to the default collection, as a recent system update
# added `module --initial_load --no_redirect restore` to /sw/andes/init/profile.
# This executes during the startup of every new shell, with no way to disable
# it without breaking all of /etc/profile.d. I'd prefer to keep the default
# collection unmodified, but my hand has been forced.
module --no_redirect save
