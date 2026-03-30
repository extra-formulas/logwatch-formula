{% from "./logwatch.map" import logwatch_map with context %}

{% if logwatch_map.use is defined %}

{% if logwatch_map.use | to_bool %}

logwatch_installation:
  pkg.installed:
    - name: {{ logwatch_map.package_name }}

logwatch_config_file:
  file.managed:
    - name: /etc/logwatch/conf/logwatch.conf
    - source: salt://logwatch/files/logwatch.conf
    - template: jinja
    - context: {{ logwatch_map }}
    - require:
      - logwatch_installation

{% else %}

logwatch_removal:
  pkg.removed:
    - name: {{ logwatch_map.package_name }}

logwatch_purge:  
  file.absent:
    - name: {{ logwatch_map.config_dir }}
    - require:
      - logwatch_removal

{% endif %}

{% endif %}