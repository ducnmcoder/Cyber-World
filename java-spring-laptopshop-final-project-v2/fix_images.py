import os
import re

base_dir = r"c:\Users\mrtin\OneDrive\Documents\GitHub\WebLaptopShop\java-spring-laptopshop-final-project-v2\src\main\webapp\WEB-INF\view"

# Pattern to find src="/images/product/${...image}"
# and replace with src="${...firstImage}"
pattern = re.compile(r'src="/images/product/\${([^}]+)\.image}"')

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Except for detail.jsp, we will do detail.jsp manually or handle it here
    if 'detail.jsp' in filepath and not 'order' in filepath:
        # We will do product/detail.jsp manually
        return

    new_content = pattern.sub(r'src="${\1.firstImage}"', content)

    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")

for root, _, files in os.walk(base_dir):
    for file in files:
        if file.endswith('.jsp'):
            process_file(os.path.join(root, file))
