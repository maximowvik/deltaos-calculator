#!/bin/bash

APP_NAME="deltaos-calculator"
VERSION="1.0.0"

echo "🚀 Начинаем сборку Flutter приложения..."
flutter build linux --release

if [ $? -ne 0 ]; then
    echo "❌ Ошибка сборки Flutter!"
    exit 1
fi

# Временная директория
TMPDIR=$(mktemp -d)
echo "📂 Создана временная директория: $TMPDIR"

mkdir -p $TMPDIR/opt/$APP_NAME
mkdir -p $TMPDIR/usr/share/applications
mkdir -p $TMPDIR/usr/share/icons/hicolor/512x512/apps
mkdir -p $TMPDIR/usr/bin

# Копирование файлов
echo "📦 Копирование файлов..."
cp -r build/linux/x64/release/bundle/* $TMPDIR/opt/$APP_NAME/

# Проверка наличия иконки
if [ -f "assets/icons/deltaos-calculator.png" ]; then
    cp assets/icons/deltaos-calculator.png $TMPDIR/usr/share/icons/hicolor/512x512/apps/$APP_NAME.png
else
    echo "⚠️ Иконка не найдена, пропускаем..."
fi

# Создание симлинка
ln -sf /opt/$APP_NAME/$APP_NAME $TMPDIR/usr/bin/$APP_NAME

# Создание .desktop файла
cat > $TMPDIR/usr/share/applications/$APP_NAME.desktop << EOF
[Desktop Entry]
Name=DeltaOS Calculator
Exec=/opt/$APP_NAME/$APP_NAME
Icon=$APP_NAME
Type=Application
Categories=Utility;Calculator;
Comment=Modern calculator with DeltaOS design
EOF

# Сборка RPM через fpm
echo "🛠️ Сборка RPM пакета..."
fpm -s dir -t rpm \
    -n $APP_NAME \
    -v $VERSION \
    --license "MIT" \
    --vendor "Viktor Maximov" \
    --maintainer "maximovviktor@gmail.com" \
    --description "Modern calculator with DeltaOS design" \
    --depends "gtk3" \
    --depends "util-linux" \
    --depends "xz-libs" \
    -C $TMPDIR \
    opt usr

# Проверка результата
if [ $? -eq 0 ]; then
    echo "✅ RPM пакет успешно создан!"
    ls -la *.rpm
else
    echo "❌ Ошибка при создании RPM пакета!"
    exit 1
fi

# Очистка
rm -rf $TMPDIR