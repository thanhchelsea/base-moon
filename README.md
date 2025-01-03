# MOON
flutter pub get
dart run intl_utils:generate
very_good create flutter_app repo  --desc "Repo web"

dart run build_runner build --delete-conflicting-outputs


sử dụng git template dưới dạng submodule:
b1: xoá bỏ index nếu có template:
    git submodule deinit -f packages/template
    rm -rf .git/modules/packages/template
    git rm -f packages/template
b2: git submodule update --init --recursive
=====> Mỗi khi thay đổi code trong template: 
b1: cd packages/template
b2: cd vào template => commit và push code bên trong template
vd: 
git add .
git commit -m "Commit thay đổi code"
git push origin your_bracnh 

b3: cd ../.. 
b4: Cập nhật Tham chiếu Submodule trong Repo Chính: Sau khi đẩy lên packages/template, hãy cập nhật repo chính để trỏ đến commit mới nhất của submodule
vd: 
git add .
git commit -m "Cập nhật submodule template đến commit mới nhất"
git push origin main
