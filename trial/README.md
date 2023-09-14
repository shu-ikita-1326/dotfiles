# Trial my neovim environment

You can try out my neovim environment using docker.  
Please note that because you are installing fewer commands, some features are no longer available.

## Depends

The following commands must be executable.

- git
- docker

## Usage

1. Build the Dockerfile.

   ```bash
   docker build -t myvim:latest --build-arg USERNAME=$(id -un) --build-arg GROUPNAME=$(id -gn) --build-arg UID=$(id -u) --build-arg GID=$(id -g) --file ./Dockerfile ../
   ```

2. Run the Docker Image.

   ```bash
   docker run --name myvim -itd myvim:latest
   docker exec -it myvim bash
   ```

3. Run nvim.  
   Start nvim with the following command.  
   After startup, the lang server will be installed, so please wait for a while.

   ```bash
   nvim
   ```

## Other

You can use this environment in any project by setting the volume during docker run.

### Example

```bash
docker run --name myvim -itd -v ~/go/src:/home/$(id -un)/go/src myvim:latest
```

## Feature introduction

After starting nvim, you can use the following functions.  
wip: Check the nvim directory in .config for configuration details.

### Key map

| Function          | Key map                           |
| ----------------- | --------------------------------- |
| Open filer        | < space + e >                     |
| Change dir to up  | < backspace > in filer            |
| Set root          | < dot > in filer                  |
| File search       | < space + ff >                    |
| File history      | < space + hh >                    |
| Git Repo history  | < space + hp >                    |
| Translate inline  | < space + tl >                    |
| Translate select  | < space + tl > in visual mode     |
| Translate word    | < space + tw > on target word     |
| Open lazygit      | < space + lg >                    |
| Live grep         | < space + slash >                 |
| Grep              | < space + ? >                     |
| Grep current word | < space + asterisk >              |
| Open outline      | < space + a >                     |
| Go to definition  | < gd > on target word or function |
| Go to reference   | < gs > on target word or function |

### Completion

The completion function starts when you type two or more characters in insert mode or < ctrl + space >.
When the completion window pops up, you can use the following commands:

| Function                | Key map      |
| ----------------------- | ------------ |
| Next completion item    | < ctrl + n > |
| Prev completion item    | < ctrl + p > |
| Confirm                 | < ctrl + y > |
| Confirm word            | < ctrl + o > |
| Close completion window | < ctrl + e > |
