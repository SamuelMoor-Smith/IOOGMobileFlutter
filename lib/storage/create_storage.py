import json

metadata = json.load(open('/Users/samuelmoor-smith/Desktop/flutter_application_2/lib/storage/metadata.json'))

def isRequired(field):
    return "true" if field["required_field"] == "y" else "false"

def create_text(field, isRequired, form):
    print('IOOGTextField {} = IOOGTextField("{}", "{}", {}, {});'.format(field['field_name'], field['field_label'], field['field_name'], form, isRequired))

def create_choices(field):
    print('Set<Choice> {}__choices = {{'.format(field['field_name']))
    choices = field['select_choices_or_calculations'].split(" | ")
    for choice in choices:
        p = choice.split(", ")
        print('\tChoice({}, "{}"),'.format(p[0], p[1]))
    print("};")

def create_radio(field, isRequired, form):
    create_choices(field)
    print('RadioButton {} = RadioButton({}__choices, "{}", "{}", {}, {});'.format(field['field_name'], field['field_name'], field['field_label'], field['field_name'], form, isRequired))
    print("")

def create_checkbox(field, isRequired, form):
    create_choices(field)
    print('CheckButton {} = CheckButton({}__choices, "{}", "{}", {}, {});'.format(field['field_name'], field['field_name'], field['field_label'], field['field_name'], form, isRequired))
    print("")

def create_storage(form, title):

    print("import 'package:namer_app/models/app_field/instrument.dart';")
    print("import 'package:namer_app/models/text_field/field.dart';")
    print("import 'package:namer_app/models/multiple_choice/choice.dart';")
    print("import 'package:namer_app/models/multiple_choice/radio_button.dart';")
    print("import 'package:namer_app/models/multiple_choice/check_group.dart';")

    print('\nInstrument {} = Instrument("{}");\n'.format(form, title))

    for field in metadata:
        if field['form_name'] == form:
            if field['field_type'] == 'text':
                create_text(field, isRequired(field), form)

    for field in metadata:
        if field['form_name'] == form:
            if field['field_type'] == 'radio':
                create_radio(field, isRequired(field), form)

    for field in metadata:
        if field['form_name'] == form:
            if field['field_type'] == "checkbox":
                create_checkbox(field, isRequired(field), form)


# create_storage("basic_demography_form", "Demographic Information")
# create_storage("preop_data", "Pre-Op Information")
# create_storage("postop_data", "Post-Op Information")
# create_storage("surgical_information", "Surgical Information")

forms = set()
for item in metadata:
    if item['form_name'] not in forms:
        forms.add(item['form_name'])

print(forms)




