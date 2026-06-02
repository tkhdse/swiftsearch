import argparse
from pathlib import Path

import requests



def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--endpoint", default="127.0.0.1:8080")
    parser.add_argument(
        "--docs",
        type=Path,
        default=Path(__file__).resolve().parent.parent/"docs"
    )
    args = parser.parse_args()
    docs_dir = args.docs

    if not docs_dir.is_dir():
        raise SystemExit(f"not a directory: {docs_dir}")
    
    url = f"http://{args.endpoint.rstrip('/')}/insert"

    for path in sorted(docs_dir.iterdir()):
        if not path.is_file():
            continue
        
        print(f"uploading {path.name} ...")
        body = path.read_bytes()
        
        payload = {
            "title": path.name,
            "body": body
        }
        response = requests.post(url, data=payload)
        response.raise_for_status()


if __name__ == "__main__":
    main()