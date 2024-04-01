# PDF Search

This bash script allows you to search for a term within PDF files in a specified directory. It presents a menu interface for selecting the directory and entering the search term. Once a search term is provided, it searches for PDF files containing the term, opens the selected PDF file using Zathura, and navigates to the page containing the first occurrence of the term.

## Dependencies

Before using this script, make sure you have the following dependencies installed on your system:

1. **Rofi**: Rofi is a window switcher, application launcher, and dmenu replacement. It provides the menu interface for selecting folders and entering search terms. You can install Rofi using your system's package manager or by compiling it from the source. Refer to the [Rofi GitHub repository](https://github.com/davatorium/rofi) for installation instructions.

2. **pdfgrep**: pdfgrep is a tool for searching text in PDF files. It is used by the script to search for the provided term within PDF files. You can install pdfgrep using your system's package manager. For example, on Ubuntu, you can install it using the command `sudo apt install pdfgrep`.

3. **zathura && zathura-pdf-poppler/**: Zathura is a highly customizable and functional PDF viewer. It is used by the script to open the selected PDF file and navigate to the page containing the first occurrence of the search term. You can install Zathura using your system's package manager. For example, on Ubuntu, you can install it using the command `sudo apt install zathura`.

## Usage

1. Clone or download the script to your local machine.
2. Make sure the script is executable by running `chmod +x pdf-search.sh`.
3. Run the script using `./pdf-search.sh`.
4. Follow the on-screen instructions to select the directory, enter the search term, and select the PDF file to view.

## License

This script is licensed under the [MIT License](LICENSE).
