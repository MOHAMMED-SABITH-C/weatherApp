import 'package:flutter/material.dart';
// import 'package:newtok_wether/adminhome.dart';
import 'package:newtok_wether/firebaseAuth.dart';
import 'package:newtok_wether/forgetPassword.dart';
import 'package:newtok_wether/register.dart';
// import 'package:newtok_wether/Uhome.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key, required this.role});
  String role = 'User';

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool passwordvisible = true;
  // String log='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [TextButton(onPressed: (){
        Navigator.pushNamedAndRemoveUntil(context, widget.role=='User'?'/Admin':'/User',(Route<dynamic> route)=>false);
        // Navigator.of(context).popUntil(ModalRoute.withName('/${widget.role}'));
      }, child: Text(widget.role=='User'?'Admin':'User',style: TextStyle(fontWeight: FontWeight.bold),),
      style: TextButton.styleFrom(
    // foregroundColor: Colors.blue,
    backgroundColor: Colors.blue,
  ),
      )],
        title: Text(widget.role,style: TextStyle(
                color: Color(0xF704357F),
                fontWeight: FontWeight.bold,
                fontSize: 35),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
        //      Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     ElevatedButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, '/admin');
        //       },
        //       child: Text('Admin'),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, '/U');
        //       },
        //       child: Text('U'),
        //     ),
        //   ],
        // ),
            Center(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 5)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Sign In'),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter ${widget.role} email',
                          // border:
                          label: Text('${widget.role} email'),
                        ),
                        controller: _email,
                      ),
                      TextField(
                        controller: _password,
                        obscureText: passwordvisible,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          suffixIcon: IconButton(
                            icon: passwordvisible == false
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                passwordvisible = !passwordvisible;
                              });
                            },
                          ),
                          // border:
                          label: Text('Password'),
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          'Forgote Password?',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => forgotPassword()));
                        },
                      ),
                      ElevatedButton(
                          //////////////////button shadow//////////////////////
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xF704357F),
                            shadowColor: Color.fromARGB(0, 0, 0, 0),
                            elevation: 10,
                            side:
                                BorderSide(color: Color.fromARGB(255, 57, 19, 71)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () {
                            // sendData(context);
            
                            if (_email.text == '' || _password.text == '') {
                              // setSp(password,email);
            
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.cyan,
                                  margin: EdgeInsets.all(10),
                                  content: Text(
                                    "Please Enter Password or Email",
                                    style: TextStyle(color: Colors.red),
                                  )));
                            } else {
                              late String email = _email.text.trim();
                              late String password = _password.text.trim();
            
                              //////////////////////validity check
                              // if( password.isNotEmpty && email.isNotEmpty){
                              AuthService(email, password, 'sign', context,
                                  widget.role); /////////
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>homepage()));
                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: ((context) {
                              //   return Uhome();//RegisterU();
                              // })),
                              // (route)=>false,
                              // );
                              // }
                            }
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ListClasses()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not a member?'),
                          //////////////////////link text on anything/////////////
                          InkWell(
                            child: Text(
                              ' Register now',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterU(role: widget.role,)));
            
                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: ((context) {
                              //   return Uhome();//RegisterU();
                              // })),
                              // (route)=>false,
                              // );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
