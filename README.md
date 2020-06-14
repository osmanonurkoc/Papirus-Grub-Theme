
## Papirus-Grub2-Theme
Material Grub2 Theme with Papirus Icon Pack
![papirus grub theme without loading bar](https://raw.githubusercontent.com/osmanonurkoc/Papirus-Grub-Theme/master/papirus_grub.png)
## Installation:

**Installer:**

Just run this command in your terminal.

    $ sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/osmanonurkoc/Papirus-Grub-Theme/master/install.sh)"

**Manual:**

 - Clone the repository `git clone https://github.com/osmanonurkoc/Papirus-Grub-Theme.git`
 - Copy the folder **Papirus/** in the themes folder where GRUB is installed: (/boot/grub/themes)
 - Edit  **/etc/default/grub**  and place the PAPIRUS theme path with your text file  **theme.txt**
`GRUB_THEME="/boot/grub/themes/Papirus/theme.txt"`
 -  Generate your grub configuration file again (sudo update-grub or grub-mkconfig)
 - That's all

## How to config theme:

Run command `sudo xed /boot/grub/grub.cfg`

*For add missing icons to grub menu entries:*

 1. Find first`menuentry "` line
 2. Add `--class "iconname"` to end of the `menuentry "entry-name"` 
 3. Look [icons](https://github.com/osmanonurkoc/Papirus-Grub-Theme/tree/master/Papirus/icons) for "iconname"
 4. Save file and reboot

It should look like the following at the end of the processes.
  `menuentry "Linux Mint 20 Cinnamon" --class linuxmint`

*For set  grub menu default entry:*

 1. Find `set default="`
 2. Add value in `set default="right-here"` to you want be a default entry
 3. For example: `set default="Linux Mint 20 Cinnamon"` like be for linux mint

 
