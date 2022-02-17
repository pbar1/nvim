FROM docker.io/library/archlinux:base-devel

RUN pacman --sync --refresh --sysupgrade --noconfirm --noprogressbar \
  neovim go gopls lua-language-server

RUN groupadd --system user && useradd --no-log-init --system --gid user user
RUN mkdir -p /home/user && chown -R user:user /home/user
USER user

RUN mkdir -p /home/user/.config/nvim
COPY init.lua /home/user/.config/nvim/

ENTRYPOINT nvim
