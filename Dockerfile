FROM debian:buster-slim

ARG LSDELUXE_VERSION=0.17.0
ARG NERDS_FONT_VERSION=2.1.0

ENV ZSH_DIR=/zsh
ENV ZSH_DOCKER=/zsh/docker

RUN set -ex \
  && mkdir $ZSH_DIR \
  && mkdir -p $ZSH_DOCKER

WORKDIR $ZSH_DIR

RUN set -ex \
  && apt-get update \
  && LSDELUXE_DEPS="ca-certificates" \
  && NERD_FONTS_DEPS="wget" \
  && OH_MY_ZSH_DEPS="wget git" \
  && apt-get install --yes --no-install-recommends \
  # install dependencies
  $LSDELUXE_DEPS \
  $NERD_FONTS_DEPS \
  $OH_MY_ZSH_DEPS \
  zsh \
  # install oh-my-zsh
  && wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | zsh || true \
  && mv /root/.oh-my-zsh $ZSH_DIR \
  # install oh-my-zsh plugins
  && ZSH_CUSTOM=$ZSH_DIR/.oh-my-zsh/custom \
  && git clone --branch '0.7.1' --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting \
  && git clone --branch 'v0.6.4' --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions \
  && git clone --branch 'v0.6.7' --depth 1 https://github.com/Powerlevel9k/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k \
  # LSDeluxe
  && LSDELUXE_DOWNLOAD_SHA256="ac85771d6195ef817c9d14f8a8a0d027461bfc290d46cb57e434af342a327bb2" \
  && wget -O lsdeluxe.deb https://github.com/Peltoche/lsd/releases/download/${LSDELUXE_VERSION}/lsd_${LSDELUXE_VERSION}_amd64.deb \
  && echo "$LSDELUXE_DOWNLOAD_SHA256  lsdeluxe.deb" | sha256sum -c - \
  && dpkg -i lsdeluxe.deb \
  && rm lsdeluxe.deb \
  # Fira Code from Nerd fonts
  && FONT_DIR=$ZSH_DIR/fonts \
  && FIRA_CODE_URL=https://github.com/ryanoasis/nerd-fonts/raw/${NERDS_FONT_VERSION}/patched-fonts/FiraCode \
  && FIRA_CODE_LIGHT_DOWNLOAD_SHA256="5e0e3b18b99fc50361a93d7eb1bfe7ed7618769f4db279be0ef1f00c5b9607d6" \
  && FIRA_CODE_REGULAR_DOWNLOAD_SHA256="3771e47c48eb273c60337955f9b33d95bd874d60d52a1ba3dbed924f692403b3" \
  && FIRA_CODE_MEDIUM_DOWNLOAD_SHA256="42dc83c9173550804a8ba2346b13ee1baa72ab09a14826d1418d519d58cd6768" \
  && FIRA_CODE_BOLD_DOWNLOAD_SHA256="060d4572525972b6959899931b8685b89984f3b94f74c2c8c6c18dba5c98c2fe" \
  && FIRA_CODE_RETINA_DOWNLOAD_SHA256="e254b08798d59ac7d02000a3fda0eac1facad093685e705ac8dd4bd0f4961b0b" \
  && mkdir -p $FONT_DIR \
  && wget -P $FONT_DIR $FIRA_CODE_URL/Light/complete/Fura%20Code%20Light%20Nerd%20Font%20Complete.ttf \
  && wget -P $FONT_DIR $FIRA_CODE_URL/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete.ttf \
  && wget -P $FONT_DIR $FIRA_CODE_URL/Medium/complete/Fura%20Code%20Medium%20Nerd%20Font%20Complete.ttf \
  && wget -P $FONT_DIR $FIRA_CODE_URL/Bold/complete/Fura%20Code%20Bold%20Nerd%20Font%20Complete.ttf \
  && wget -P $FONT_DIR $FIRA_CODE_URL/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete.ttf \
  && echo "$FIRA_CODE_LIGHT_DOWNLOAD_SHA256  $FONT_DIR/Fura Code Light Nerd Font Complete.ttf" | sha256sum -c - \
  && echo "$FIRA_CODE_REGULAR_DOWNLOAD_SHA256  $FONT_DIR/Fura Code Regular Nerd Font Complete.ttf" | sha256sum -c - \
  && echo "$FIRA_CODE_MEDIUM_DOWNLOAD_SHA256  $FONT_DIR/Fura Code Medium Nerd Font Complete.ttf" | sha256sum -c - \
  && echo "$FIRA_CODE_BOLD_DOWNLOAD_SHA256  $FONT_DIR/Fura Code Bold Nerd Font Complete.ttf" | sha256sum -c - \
  && echo "$FIRA_CODE_RETINA_DOWNLOAD_SHA256  $FONT_DIR/Fura Code Retina Nerd Font Complete.ttf" | sha256sum -c - \
  # clean cache and temporary files
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* *.deb \
  && apt-get remove --yes \
  $LSDELUXE_DEPS \
  $NERD_FONTS_DEPS \
  $OH_MY_ZSH_DEPS

COPY ./config/.zshrc $ZSH_DOCKER/.zshrc
COPY ./config/aliases.zsh $ZSH_DOCKER/aliases.zsh

CMD ["bash"]
