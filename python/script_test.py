import sys
import unittest
from mock import patch, MagicMock

sys.modules['vim'] = MagicMock()
import script

data_get_decl = [
    ("", None),
    ("var my_var", script.VarDecl(0, "my_var", None)),
    ("var myVar ", script.VarDecl(0, "myVar", None)),
    ("var my_var : Vector2", script.VarDecl(0, "my_var", "Vector2")),
    ("var my_var : Vector2 = Vector2(1,3)", script.VarDecl(0, "my_var", "Vector2")),
    ("var my_var:Vector2=Vector2(1,3)", script.VarDecl(0, "my_var", "Vector2")),
    ("var my_var := Vector2(1,3)", script.VarDecl(0, "my_var", "Vector2")),
    ("var my_var := Vector2(1,  3)", script.VarDecl(0, "my_var", "Vector2")),
    ("var my_var := Vector2(1,3)  ", script.VarDecl(0, "my_var", "Vector2")),
    ("var my_var := Vector2(1,3)  # comment", script.VarDecl(0, "my_var", "Vector2")),
    ("var my_var := Vector2(1,3)  # comment ", script.VarDecl(0, "my_var", "Vector2")),
    ("var my_var := Vector2(1,  3)  # comment ", script.VarDecl(0, "my_var", "Vector2")),
    ("    var my_var", script.VarDecl(0, "my_var", None)),
    ("const my_const : Vector2 = Vector2(1,3)", script.ConstDecl(0, "my_const", "Vector2(1,3)", "Vector2")),
    ("const myConst : Vector2 = Vector2(1,3) ", script.ConstDecl(0, "myConst", "Vector2(1,3)", "Vector2")),
    ("const my_const := Vector2(1,3)", script.ConstDecl(0, "my_const", "Vector2(1,3)", "Vector2")),
    ("const my_const := Vector2(1,3)  ", script.ConstDecl(0, "my_const", "Vector2(1,3)", "Vector2")),
    # ("const my_const := \"some String§$%*+#\"", script.ConstDecl(0, "my_const", "\"some String§$%*+#\"", "String")),
    ("const my_const := Vector2(1, 3)  ", script.ConstDecl(0, "my_const", "Vector2(1, 3)", "Vector2")),
    ("const my_const := Vector2(1,3)  # comment", script.ConstDecl(0, "my_const", "Vector2(1,3)", "Vector2")),
    ("const my_const := Vector2(1,3)  # comment ", script.ConstDecl(0, "my_const", "Vector2(1,3)", "Vector2")),
    ("const my_const := Vector2(1,  3)  # comment ", script.ConstDecl(0, "my_const", "Vector2(1,  3)", "Vector2")),
    ("    const my_const : Vector2 = Vector2(1,3)", script.ConstDecl(0, "my_const", "Vector2(1,3)", "Vector2")),
    ("func my_func:", None),
    ("func my_func():", script.FuncDecl(0, False, "my_func", [], None)),
    ("func  my_func (  ) : ", script.FuncDecl(0, False, "my_func", [], None)),
    ("static func myFunc():", script.FuncDecl(0, True, "myFunc", [], None)),
    ("func myFunc(arg1, arg2):", script.FuncDecl(0, False, "myFunc", ["arg1", "arg2"], None)),
    ("func myFunc(  arg1  , arg2  ):", script.FuncDecl(0, False, "myFunc", ["arg1", "arg2"], None)),
    ("func my_func(Arg_1,Arg_2) -> void:", script.FuncDecl(0, False, "my_func", ["Arg_1", "Arg_2"], "void")),
    ("static func my_func(Arg_1,Arg_2) -> void:", script.FuncDecl(0, True, "my_func", ["Arg_1", "Arg_2"], "void")),
    ("func my_func() -> Vector2:", script.FuncDecl(0, False, "my_func", [], "Vector2")),
    ("    func my_func:", None),
    ("enum MY_ENUM{", script.EnumDecl(0, "MY_ENUM")),
    ("enum my_enum { ", script.EnumDecl(0, "my_enum")),
    ("enum myEnum", script.EnumDecl(0, "myEnum")),
    ("enum  myEnum  ", script.EnumDecl(0, "myEnum")),
    ("    enum MY_ENUM{", script.EnumDecl(0, "MY_ENUM")),
    ("class MyClass:", script.ClassDecl(0, "MyClass", None)),
    ("class  my_class : ", script.ClassDecl(0, "my_class", None)),
    ("class  my_class extends Vector2: ", script.ClassDecl(0, "my_class", "Vector2")),
    ("class my_class  extends   Vector2 : ", script.ClassDecl(0, "my_class", "Vector2")),
    ("    class MyClass:", script.ClassDecl(0, "MyClass", None)),
]

@patch('classes._JSON_DIR', './json/')
class TestGetDecl(unittest.TestCase):

    def test_basic_decls(self):
        for item in data_get_decl:
            with patch('util.get_line', return_value=item[0]) as get_line_mock:
                decl = script._get_decl(0, script.ANY_DECLS)
                self.assertEqual(decl, item[1], "line='{}'".format(item[0]))
                self.assertTrue(get_line_mock.called)

    def test_flags(self):
        for item in data_get_decl:
            with patch('util.get_line', return_value=item[0]) as get_line_mock:
                decl = script._get_decl(0, script.VAR_DECLS)
                if type(item[1]) is script.VarDecl:
                    self.assertIs(type(decl), script.VarDecl)
                else:
                    self.assertIsNone(decl)
                decl = script._get_decl(0, script.CONST_DECLS)
                if type(item[1]) is script.ConstDecl:
                    self.assertIs(type(decl), script.ConstDecl)
                else:
                    self.assertIsNone(decl)
                decl = script._get_decl(0, script.FUNC_DECLS)
                if type(item[1]) is script.FuncDecl:
                    self.assertIs(type(decl), script.FuncDecl)
                else:
                    self.assertIsNone(decl)
                decl = script._get_decl(0, script.ENUM_DECLS)
                if type(item[1]) is script.EnumDecl:
                    self.assertIs(type(decl), script.EnumDecl)
                else:
                    self.assertIsNone(decl)
                decl = script._get_decl(0, script.CLASS_DECLS)
                if type(item[1]) is script.ClassDecl:
                    self.assertIs(type(decl), script.ClassDecl)
                else:
                    self.assertIsNone(decl)
                self.assertTrue(get_line_mock.called)


data_get_inferred_type = [
    ("Vector2(23,5)", "Vector2"),
    ("Vector3(1,4,6)", "Vector3"),
    ("Vector2(23,5).x", "float"),
    ("Vector2(23,5).angle()", "float"),
    ("\"some String\"", "String"),
]

@patch('classes._JSON_DIR', './json/')
class TestGetInferredType(unittest.TestCase):

    def test_BuiltinDecls(self):
        for item in data_get_inferred_type:
            inf_type = script.get_inferred_type(item[0], 0, len(item[0]))
            self.assertEqual(inf_type, item[1])

    def test_StringLiterals(self):
        for item in data_get_inferred_type:
            inf_type = script.get_inferred_type(item[0], 0, len(item[0]))
            self.assertEqual(inf_type, item[1])
