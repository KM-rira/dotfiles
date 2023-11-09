import os
import json

# ブックマークのJSONデータ
bookmark_data = "~/AppData/Local/Google/Chrome/User Data/Default/Bookmarks"

# ブックマークのルートディレクトリ
root_folder = bookmark_data["roots"]

# ブックマークをNameごとに保存するフォルダーのパス
output_folder = os.path.expanduser("~/bookmark")

# ブックマークをNameごとにファイルに保存
for folder_name, folder_data in root_folder.items():
    if "children" in folder_data:
        for bookmark in folder_data["children"]:
            if "name" in bookmark and "url" in bookmark:
                name = bookmark["name"]
                url = bookmark["url"]
                folder_path = os.path.join(output_folder, name)
                os.makedirs(folder_path, exist_ok=True)
                with open(os.path.join(folder_path, name + ".txt"), "w") as file:
                    file.write(url)