FROM nvcr.io/nvidia/pytorch:23.12-py3

RUN groupadd -g 1000 ubuntu && \
    useradd -m -u 1000 -g 1000 -s /bin/bash ubuntu
RUN chown -R ubuntu:ubuntu /home/ubuntu

RUN mkdir /nix
RUN chown ubuntu /nix

# Set the working directory
USER ubuntu

WORKDIR /home/ubuntu
ENV HOME=/home/ubuntu

RUN bash <(curl -L https://nixos.org/nix/install) --no-daemon
RUN source $HOME/.nix-profile/etc/profile.d/nix.sh
RUN echo 'source $HOME/.nix-profile/etc/profile.d/nix.sh' > ~/.bashrc
ENV PATH="$HOME/.nix-profile/bin:$PATH"

RUN nix-channel --add https://nixos.org/channels/nixos-24.05 nixpkgs
RUN nix-channel --add https://nixos.org/channels/nixos-unstable unstable
RUN nix-channel --update
RUN nix-env -iA unstable.neovim nixpkgs.tmux nixpkgs.yazi nixpkgs.starship nixpkgs.fzf nixpkgs.ripgrep nixpkgs.fd nixpkgs.zoxide nixpkgs.fish nixpkgs.eza nixpkgs.bat nixpkgs.dust

# Set the default command
CMD ["sleep", "infinity"]
