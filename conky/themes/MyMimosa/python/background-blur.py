#!/home/ronnas/develop/personal/dotfiles/conky/themes/MyMimosa/python/.venv/bin/python3
"""Generate blurred, cropped background pieces for the MyMimosa conky theme."""

from glob import glob
import json
import os
from random import choices
import subprocess

import cv2

PROPORTION = 100 / 125
WIDTH = int(PROPORTION * 1920)
HEIGHT = int(PROPORTION * 1080)
HOME = os.path.expanduser("~")


def generate_image(
    img: cv2.typing.MatLike,
    newpath: str,
    reference: str,
    dimensions: list[int],
) -> None:
    """Crop `img`, blend in `reference`'s alpha mask, save to `newpath`.

    Args:
        img: source image to crop.
        newpath: output file path.
        reference: path to alpha-mask reference image, or "" to skip blending.
        dimensions: [x, y, width, height] crop box.

    Raises:
        FileNotFoundError: if `reference` is set but can't be read.
    """
    [x, y, width, height] = dimensions
    img = img[y : y + height, x : x + width]
    if reference:
        ref_img = cv2.imread(
            reference,
            cv2.IMREAD_UNCHANGED,
        )
        if ref_img is None:
            msg = f"could not read reference image: {reference}"
            raise FileNotFoundError(msg)
        ref_img = cv2.resize(ref_img, (width, height))
        img = cv2.addWeighted(src1=img, alpha=0.2, src2=ref_img, beta=0.8, gamma=0)
        alpha = ref_img[:, :, 3]
        _, mask = cv2.threshold(alpha, 0, 255, cv2.THRESH_BINARY)
        img = cv2.bitwise_and(img, img, mask=mask)
    cv2.imwrite(newpath, img)


GSETTINGS_BIN = "/usr/bin/gsettings"

path = (
    subprocess.run(  # noqa: S603 - fixed argv, no untrusted input
        [GSETTINGS_BIN, "get", "org.cinnamon.desktop.background", "picture-uri"],
        stdout=subprocess.PIPE,
        check=True,
    )
    .stdout.decode()
    .strip()
)
os.makedirs(f"{HOME}/.config/conky/MyMimosa/.cache", exist_ok=True)

images = glob(f"{HOME}/Pictures/wallpapers/images/*.*")
if not os.path.exists(f"{HOME}/.config/conky/MyMimosa/.cache/stats.json"):
    stats: dict = {"next": "", "list": {}}
    stats_path = f"{HOME}/.config/conky/MyMimosa/.cache/stats.json"
    with open(stats_path, "w", encoding="utf-8") as file:
        for image in images:
            img_name = os.path.basename(image).split(".")[0]
            stats["list"][img_name] = 0
        file.write(json.dumps(stats))
ref_path = f"{HOME}/.config/conky/MyMimosa/.cache/ref.json"
if not os.path.exists(ref_path):
    with open(ref_path, "w", encoding="utf-8") as file:
        file.write(json.dumps({"reference": ""}))

with open(ref_path, encoding="utf-8") as file:
    data = json.loads(file.read())


filepath = path.replace("file://", "").replace("'", "")
name = os.path.basename(filepath).split(".")[0]


if data["reference"] != name:
    stats_path = f"{HOME}/.config/conky/MyMimosa/.cache/stats.json"
    with open(stats_path, "r+", encoding="utf-8") as file:
        stats = json.loads(file.read())
        stats["list"][name] = stats["list"].get(name, 0) + 1
        s = sum(stats["list"].values())
        prob = {k: 0.99999 - v / (s if s > 0 else 1) for k, v in stats["list"].items()}
        value = choices(list(prob.keys()), weights=list(prob.values()), k=1)  # noqa: S311
        while value[0] == name:
            value = choices(list(prob.keys()), weights=list(prob.values()), k=1)  # noqa: S311
        value_path = f"{HOME}/Pictures/wallpapers/images/{value[0]}.jpeg"
        if value_path not in images:
            del stats["list"][value[0]]
        else:
            stats["next"] = value_path
            file.seek(0)
            file.write(json.dumps(stats))

    newpath_rings = f"{HOME}/.config/conky/MyMimosa/.cache/vert_{name}.png"
    reference_rings = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-piece-s.png"
    rings_dimensions = {"x": 15, "y": 373, "width": 245, "height": 245}

    newpath_rss = f"{HOME}/.config/conky/MyMimosa/.cache/rss_{name}.png"
    reference_rss = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-piece-s.png"
    rss_dimensions = {"x": 15, "y": 69, "width": 245, "height": 294}

    newpath_main = f"{HOME}/.config/conky/MyMimosa/.cache/main_{name}.png"
    reference_main = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-main.png"
    main_dimensions = {"x": 1199, "y": 69, "width": 322, "height": 708}

    newpath_calendar = f"{HOME}/.config/conky/MyMimosa/.cache/calendar_{name}.png"
    reference_calendar = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-piece-h.png"
    calendar_dimensions = {"x": 15, "y": 628, "width": 414, "height": 128}

    newpath_player = f"{HOME}/.config/conky/MyMimosa/.cache/player_{name}.png"
    reference_player = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-player.png"
    player_dimensions = {"x": 938, "y": 407, "width": 261, "height": 365}

    newpath_bar = f"{HOME}/.config/conky/MyMimosa/.cache/bar_{name}.png"

    is_processed = os.path.exists(newpath_rings)
    img = cv2.imread(filepath)
    if img is None:
        msg = f"could not read wallpaper image: {filepath}"
        raise FileNotFoundError(msg)
    img = cv2.resize(img, (WIDTH, HEIGHT))
    img = cv2.blur(img, (15, 15))
    img = cv2.cvtColor(img, cv2.COLOR_BGR2BGRA)
    cv2.imwrite(f"{HOME}/.config/conky/MyMimosa/.cache/current_background.png", img)
    if not is_processed:
        generate_image(
            img,
            newpath_rings,
            reference_rings,
            [
                rings_dimensions["x"],
                rings_dimensions["y"],
                rings_dimensions["width"],
                rings_dimensions["height"],
            ],
        )
        generate_image(
            img,
            newpath_rss,
            reference_rss,
            [
                rss_dimensions["x"],
                rss_dimensions["y"],
                rss_dimensions["width"],
                rss_dimensions["height"],
            ],
        )
        generate_image(
            img,
            newpath_main,
            reference_main,
            [
                main_dimensions["x"],
                main_dimensions["y"],
                main_dimensions["width"],
                main_dimensions["height"],
            ],
        )

        generate_image(
            img,
            newpath_calendar,
            reference_calendar,
            [
                calendar_dimensions["x"],
                calendar_dimensions["y"],
                calendar_dimensions["width"],
                calendar_dimensions["height"],
            ],
        )
        generate_image(
            img,
            newpath_player,
            reference_player,
            [
                player_dimensions["x"],
                player_dimensions["y"],
                player_dimensions["width"],
                player_dimensions["height"],
            ],
        )
        generate_image(
            img,
            newpath_bar,
            "",
            [0, 0, WIDTH, 42],
        )

    with open(ref_path, "w", encoding="utf-8") as file:
        file.write(
            json.dumps(
                {
                    "vert": newpath_rings,
                    "rss": newpath_rss,
                    "main": newpath_main,
                    "calendar": newpath_calendar,
                    "player": newpath_player,
                    "bar": newpath_bar,
                    "reference": name,
                }
            )
        )
