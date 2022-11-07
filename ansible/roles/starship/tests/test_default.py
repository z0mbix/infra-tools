def test_binary_exists(host):
    file = host.file('/usr/local/bin/starship')
    assert file.exists
    assert file.user == "root"
    assert file.group == "root"
    assert file.mode == 0o755


def test_binary_is_executable(host):
    cmd = host.command('/usr/local/bin/starship --version')
    assert cmd.rc == 0
