#!/usr/bin/python3
import jinja2
import argparse


parser = argparse.ArgumentParser(description='Prepare handout')
parser.add_argument('path', type=str, nargs='?')
parser.add_argument('--handout', type=bool, nargs='?',
                    const=True, default=False)
options = parser.parse_args()


env = jinja2.Environment(loader=jinja2.FileSystemLoader('.'),
                         variable_start_string='{{-',
                         variable_end_string='-}}',
                         block_start_string='{{%',
                         block_end_string='%}}',
                         comment_start_string='{@',
                         comment_end_string='@}')
template = env.get_template(options.path)
print(template.render(handout=options.handout))
