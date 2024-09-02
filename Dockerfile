FROM nvcr.io/nvidia/pytorch:22.12-py3

RUN apt-get update && apt-get install --no-install-recommends -y  locales curl xz-utils vim  ca-certificates && apt-get clean && rm -rf /var/lib/apt/lists/* \
      && mkdir -m 0755 /nix && groupadd -r nixbld && chown root /nix \
      && for n in $(seq 1 10); do useradd -c "Nix build user $n" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(command -v nologin)" "nixbld$n"; done
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN set -o pipefail && curl -L https://nixos.org/nix/install | bash

# Create the tiso user
RUN groupadd -g 1000 ubuntu && \
    useradd -m -u 1000 -g 1000 -s /bin/bash ubuntu

# Set up the home directory
RUN chown -R ubuntu:ubuntu /home/ubuntu

# Install any additional packages if needed
# RUN apt-get update && apt-get install -y package-name

# Set the working directory
WORKDIR /home/ubuntu

RUN cp -r /root/.nix-profile /home/ubuntu/.nix-profile
RUN chown -R ubuntu:ubuntu /home/ubuntu/.nix-profile
RUN source /home/ubuntu/.nix-profile/etc/profile.d/nix.sh
ENV PATH="/home/ubuntu/.nix-profile/bin:$PATH"

RUN chmod 755 /nix/var/nix/profiles/per-user
RUN chown -R ubuntu:ubuntu /nix/var/nix/profiles/per-user
RUN chmod 755 /nix/var/nix/gcroots/per-user
RUN chown -R ubuntu:ubuntu /nix/var/nix/gcroots/per-user

# Switch to the ubuntu user
USER ubuntu

# Set the default command
CMD ["sleep", "infinity"]
