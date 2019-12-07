from bs4 import BeautifulSoup


def Clean_InnerHTML(raw_text=None):
    soup = BeautifulSoup(
        raw_text,
        features="html.parser"
    )

    return soup.get_text()
