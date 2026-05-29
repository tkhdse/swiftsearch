import argparse
from pathlib import Path

import requests



def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--endpoint", default="127.0.0.1:8080")
    parser.add_argument(
        "--inputs",
        type=Path,
        default=Path(__file__).resolve().parent.parent/"inputs"
    )
    args = parser.parse_args()
    inputs_dir = args.inputs

    if not inputs_dir.is_dir():
        raise SystemExit(f"not a directory: {inputs_dir}")
    
    url = f"http://{args.endpoint.rstrip('/')}/insert"

    for path in sorted(inputs_dir.iterdir()):
        if not path.is_file():
            continue
        
        print(f"uploading {path.name} ...")
        body = path.read_bytes()

        response = requests.post(url, data=body)
        response.raise_for_status()


if __name__ == "__main__":
    main()