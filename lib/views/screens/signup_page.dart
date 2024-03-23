import 'package:flutter/material.dart';
import '../services/signup_services.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignupService _signupService = SignupService();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _panController = TextEditingController();
    final TextEditingController _phoneNumberController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Create\nan account',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/images/globe.png', // Replace 'your_image.png' with your actual image path
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(0),
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Colors.grey, // Adjust color as needed
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffD2A500),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _panController,
                  decoration: const InputDecoration(
                    labelText: 'PAN Card',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff59BD8B),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 0, // Remove elevation
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      // Call signup function with controller values
                      bool signupSuccess = await _signupService.signup(
                        _nameController.text,
                        _emailController.text,
                        _passwordController.text,
                        'userType', // Replace with actual user type
                        _panController.text,
                        _phoneNumberController.text,
                      );
                      if (signupSuccess) {
                        Navigator.pushNamed(context, '/home_page');
                      } else {
                        // Signup failed, show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signup failed. Please try again.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Signup', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigate to login page
                    Navigator.pop(context);
                  },
                  child: Text('Existing User? Login', style: TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
