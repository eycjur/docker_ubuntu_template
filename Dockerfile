FROM ubuntu:20.04

RUN apt update && apt install -y sudo git make neovim vim zsh

RUN git clone https://github.com/eycjur/dotfiles.git ~/dotfiles
RUN ~/dotfiles/install.sh

CMD ["/bin/zsh"]
