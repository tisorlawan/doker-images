FROM nvcr.io/nvidia/pytorch:23.12-py3

RUN groupadd -g 1000 ubuntu && \
    useradd -m -u 1000 -g 1000 -s /bin/bash ubuntu
RUN chown -R ubuntu:ubuntu /home/ubuntu

RUN mkdir /tmp/extra
RUN cd /tmp/extra
RUN wget -L 'https://gitlab.com/proot/proot/-/jobs/2370229669/artifacts/raw/public/bin/proot?inline=false' -O proot
RUN chmod +x proot
RUN mv proot /usr/local/bin
RUN rm -r /tmp/extra

# Set the working directory
WORKDIR /home/ubuntu
ENV HOME=/home/ubuntu

# Switch to the ubuntu user
USER ubuntu

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
ENV PATH="$HOME/.cargo/bin:${PATH}"
RUN ~/.cargo/bin/cargo install nix-user-chroot
RUN mkdir -m 0755 ~/.nix
# RUN ~/.cargo/bin/nix-user-chroot ~/.nix bash -c 'curl -L https://nixos.org/nix/install | sh'

# # ENV PATH="/home/ubuntu/.nix-profile/bin:$PATH"
#
# RUN mkdir -p ~/.config/nix
# RUN echo 'sandbox = false' > ~/.config/nix/nix.conf

# RUN mkdir -p ~/.nix

# RUN proot -b /home/ubuntu/.nix:/nix /bin/sh -c 'curl -L https://nixos.org/nix/install | sh -s -- --no-daemon'
#
# RUN proot -b ~/.nix:/nix /bin/sh -c 'nix-channel --add https://nixos.org/channels/nixos-24.05 nixpkgs'
# RUN proot -b ~/.nix:/nix /bin/sh -c 'nix-channel --add https://nixos.org/channels/nixos-unstable unstable'
# RUN proot -b ~/.nix:/nix /bin/sh -c 'nix-channel --update'
# RUN proot -b ~/.nix:/nix /bin/sh -c 'nix-env -iA unstable.neovim nixpkgs.tmux nixpkgs.yazi nixpkgs.starship nixpkgs.fzf nixpkgs.ripgrep nixpkgs.fd nixpkgs.zoxide nixpkgs.fish nixpkgs.eza nixpkgs.bat nixpkgs.dust'
#
#
# RUN echo "alias pp='proot -b ~/.nix:/nix'" >>~/.bashrc
# RUN echo "alias f='proot -b ~/.nix:/nix sh -c fish'" >>~/.bashrc

# RUN source /home/ubuntu/.nix-profile/etc/profile.d/nix.sh

# Set the default command
CMD ["sleep", "infinity"]
