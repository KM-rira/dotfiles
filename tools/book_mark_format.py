import os
import json
import shutil

def sanitize_filename(filename):
    # Windowsファイル名で許可されていない文字
    invalid_chars = ['<', '>', ':', '"', '/', '\\', '|', '?', '*', ' ']
    
    # 無効な文字を '_' に置換
    for char in invalid_chars:
        filename = filename.replace(char, '_')
    
    return filename

# JSONファイルのパス
home_dir = os.path.expanduser("~")
json_file_path = home_dir + "/AppData/Local/Google/Chrome/User Data/Default/Bookmarks"

try:
    # JSONファイルを開いてデータを読み込む
    with open(json_file_path, 'r', encoding='utf-8') as json_file:
        json_data = json.load(json_file)
    
    # JSONデータを変数に格納しました
    print("JSONデータの読み込みに成功しました:")
    print(json_data)
    
except FileNotFoundError:
    print(f"指定されたJSONファイルが見つかりません: {json_file_path}")
except json.JSONDecodeError as e:
    print(f"JSONデータを解析できません: {e}")
except Exception as e:
    print(f"エラーが発生しました: {e}")

# ブックマークのJSONデータ
bookmark_data = json_data
# ブックマークのルートディレクトリ
root_folder = bookmark_data["roots"]
# ブックマークをNameごとに保存するフォルダーのパス
output_folder = os.path.expanduser("~/bookmark")
# フォルダを作成
if not os.path.exists(output_folder):
    os.mkdir(output_folder)

# ディレクトリが存在することを確認
if os.path.exists(output_folder) and os.path.isdir(output_folder):
    # ディレクトリ内のファイルを列挙し、削除
    for filename in os.listdir(output_folder):
        file_path = os.path.join(output_folder, filename)
        if os.path.isfile(file_path):
            os.remove(file_path)
    
    print(f"{output_folder} 内のファイルを削除しました。")
else:
    print(f"{output_folder} は存在しないか、ディレクトリではありません。")

# ブックマークをNameごとにファイルに保存
for folder_name, folder_data in root_folder.items():
    if "children" in folder_data:
        for bookmark in folder_data["children"]:
            if "name" in bookmark and "url" in bookmark:
                name = bookmark["name"]
                url = bookmark["url"]
                replace_name = sanitize_filename(name)
                with open(os.path.join(output_folder, replace_name), "w") as file:
                    file.write(url)
                
print("===== Done format bookmark json =====")
