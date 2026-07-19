import os
import re

create_file = 'src/main/webapp/WEB-INF/view/admin/product/create.jsp'
update_file = 'src/main/webapp/WEB-INF/view/admin/product/update.jsp'

with open(create_file, 'r', encoding='utf-8') as f:
    create_content = f.read()

with open(update_file, 'r', encoding='utf-8') as f:
    update_content = f.read()

spec_start_marker = '<h4 class="mt-5 mb-3 w-100" style="border-bottom: 1px solid #ccc; padding-bottom: 10px;">Detailed Specifications</h4>'
spec_end_marker = '<div class="col-12 mb-5">'
spec_block = create_content.split(spec_start_marker)[1].split(spec_end_marker)[0]

update_pre_spec = update_content.split(spec_start_marker)[0]
update_post_spec = update_content.split(spec_end_marker)[1]
update_content = update_pre_spec + spec_start_marker + spec_block + spec_end_marker + update_post_spec

target_dropdown_html = '''<label class="form-label">Target:</label>
    <div class="dropdown w-100">
        <button class="form-select text-start bg-white" type="button" id="targetDropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
            Select Targets
        </button>
        <ul class="dropdown-menu w-100" aria-labelledby="targetDropdown">
            <li class="dropdown-item px-2 py-1">
                <div class="form-check">
                    <input class="form-check-input target-checkbox" type="checkbox" value="GAMING" id="target_1">
                    <label class="form-check-label w-100" for="target_1">Gaming</label>
                </div>
            </li>
            <li class="dropdown-item px-2 py-1">
                <div class="form-check">
                    <input class="form-check-input target-checkbox" type="checkbox" value="SINHVIEN-VANPHONG" id="target_2">
                    <label class="form-check-label w-100" for="target_2">Sinh viên - Van phòng</label>
                </div>
            </li>
            <li class="dropdown-item px-2 py-1">
                <div class="form-check">
                    <input class="form-check-input target-checkbox" type="checkbox" value="THIET-KE-DO-HOA" id="target_3">
                    <label class="form-check-label w-100" for="target_3">Thi?t k? d? h?a</label>
                </div>
            </li>
            <li class="dropdown-item px-2 py-1">
                <div class="form-check">
                    <input class="form-check-input target-checkbox" type="checkbox" value="MONG-NHE" id="target_4">
                    <label class="form-check-label w-100" for="target_4">M?ng nh?</label>
                </div>
            </li>
            <li class="dropdown-item px-2 py-1">
                <div class="form-check">
                    <input class="form-check-input target-checkbox" type="checkbox" value="DOANH-NHAN" id="target_5">
                    <label class="form-check-label w-100" for="target_5">Doanh nhân</label>
                </div>
            </li>
        </ul>
        <form:input type="hidden" path="target" id="hiddenTarget" />
    </div>'''

target_pattern = re.compile(r'<label class="form-label">Target:</label>\s*<form:select class="form-select" path="target">.*?</form:select>', re.DOTALL)

create_content = target_pattern.sub(target_dropdown_html, create_content)
update_content = target_pattern.sub(target_dropdown_html, update_content)

js_script = '''
<script>
    $(document).ready(function() {
        var initialTargets = $('#hiddenTarget').val();
        if (initialTargets) {
            var targetArr = initialTargets.split(',');
            $('.target-checkbox').each(function() {
                if (targetArr.includes($(this).val())) {
                    $(this).prop('checked', true);
                }
            });
            var selectedText = targetArr.length > 0 ? targetArr.length + " selected" : "Select Targets";
            $('#targetDropdown').text(selectedText);
        }

        $('.target-checkbox').change(function() {
            var selected = [];
            $('.target-checkbox:checked').each(function() {
                selected.push($(this).val());
            });
            $('#hiddenTarget').val(selected.join(','));
            var text = selected.length > 0 ? selected.length + " selected" : "Select Targets";
            $('#targetDropdown').text(text);
        });
    });
</script>
</body>'''

create_content = create_content.replace('</body>', js_script)
update_content = update_content.replace('</body>', js_script)

with open(create_file, 'w', encoding='utf-8') as f:
    f.write(create_content)

with open(update_file, 'w', encoding='utf-8') as f:
    f.write(update_content)

print('Updated both JSP files successfully!')
