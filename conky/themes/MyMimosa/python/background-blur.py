import json
import os
import subprocess
from glob import glob

import cv2

WIDTH = 1366
HEIGHT = 768
HOME = os.path.expanduser("~")


def generate_image(img, newpath, reference, dimensions):
    [x, y, width, height] = dimensions
    img = img[y : y + height, x : x + width]
    if reference:
        refImg = cv2.imread(
            reference,
            cv2.IMREAD_UNCHANGED,
        )
        refImg = cv2.resize(refImg, (width, height))
        img = cv2.addWeighted(src1=img, alpha=0.2, src2=refImg, beta=0.8, gamma=0)
        alpha = refImg[:, :, 3]
        _, mask = cv2.threshold(alpha, 0, 255, cv2.THRESH_BINARY)
        img = cv2.bitwise_and(img, img, mask=mask)
    cv2.imwrite(newpath, img)


path = (
    subprocess.run(
        f"gsettings get org.cinnamon.desktop.background picture-uri",
        stdout=subprocess.PIPE,
        shell=True,
    )
    .stdout.decode()
    .strip()
)
if not os.path.exists(f"{HOME}/.cache/background-blur"):
    os.system("mkdir {HOME}/.cache/background-blur")
if not os.path.exists(f"{HOME}/.cache/background-blur/stats.json"):
    images = glob(f"{HOME}/Pictures/wallpapers/images/*.*")
    stats = {"next": "", "list": {}}
    with open(f"{HOME}/.cache/background-blur/stats.json", "w") as file:
        for image in images:
            img_name = os.path.basename(image).split(".")[0]
            stats["list"][img_name] = 0
        file.write(json.dumps(stats))
if not os.path.exists(f"{HOME}/.cache/background-blur/ref.json"):
    with open(f"{HOME}/.cache/background-blur/ref.json", "w") as file:
        file.write(json.dumps(dict(reference="")))

with open(f"{HOME}/.cache/background-blur/ref.json") as file:
    data = json.loads(file.read())


filepath = path.replace("file://", "").replace("'", "")
name = os.path.basename(filepath).split(".")[0]


if data["reference"] != name:
    with open(f"{HOME}/.cache/background-blur/stats.json", "r+") as file:
        stats = json.loads(file.read())
        stats["list"][name] = stats.get(name, 0) + 1
        s = sum(stats["list"].values())
        prob = [[k, 1 - v / s if s > 0 else 1] for k, v in stats["list"].items()]
        prob.sort(key=lambda x: x[1], reverse=True)
        stats["next"] = f"{HOME}/Pictures/wallpapers/images/{prob[0][0]}.jpeg"
        file.seek(0)
        file.write(json.dumps(stats))
    newpath_vert = f"{HOME}/.cache/background-blur/vert_{name}.png"
    reference_vert = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-piece-s.png"

    newpath_main = f"{HOME}/.cache/background-blur/main_{name}.png"
    reference_main = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-main.png"

    newpath_calendar = f"{HOME}/.cache/background-blur/calendar_{name}.png"
    reference_calendar = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-piece-h.png"

    newpath_player = f"{HOME}/.cache/background-blur/player_{name}.png"
    reference_player = f"{HOME}/.config/conky/MyMimosa/res/dark5/bg-piece-s.png"

    newpath_bar = f"{HOME}/.cache/background-blur/bar_{name}.png"

    isProcessed = (
        subprocess.run(
            f"ls {HOME}/.cache/background-blur/*png | grep {newpath_vert}",
            stdout=subprocess.PIPE,
            shell=True,
        )
        .stdout.decode()
        .strip()
    )
    img = cv2.imread(filepath)
    img = cv2.resize(img, (WIDTH, HEIGHT))
    img = cv2.blur(img, (21, 21))
    img = cv2.cvtColor(img, cv2.COLOR_BGR2BGRA)
    if not isProcessed:
        generate_image(img, newpath_vert, reference_vert, [20, 360, 220, 200])
        generate_image(img, newpath_main, reference_main, [1046, 70, 310, 630])
        generate_image(img, newpath_calendar, reference_calendar, [20, 590, 310, 116])
        generate_image(img, newpath_player, reference_player, [826, 350, 220, 342])
        generate_image(img, newpath_bar, "", [0, 0, 1366, 42])

    with open(f"{HOME}/.cache/background-blur/ref.json", "w") as file:
        file.write(
            json.dumps(
                {
                    "vert": newpath_vert,
                    "main": newpath_main,
                    "calendar": newpath_calendar,
                    "player": newpath_player,
                    "bar": newpath_bar,
                    "reference": name,
                }
            )
        )
