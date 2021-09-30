import db from "../models";
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'

const SignUp = (req, res) => {
    const { firstname, lastname, email, phone, dateOfBirth, password } = req.body;
    console.log(req.body);

    db.sequelize
        .query(`SELECT  max(id) + 1 as id from users `)
        .then((result) => {
            let maxId = result[0][0].id;
            console.log(maxId);

            db.sequelize.query(`SELECT * from users where email="${email}"`)
                .then(resp => {
                    if (resp[0].length) {
                        console.log('user exist')
                        return res.status(400).json({ success: false, msg: 'email already registered' })
                    } else {
                        bcrypt.genSalt(10, (err, salt) => {
                            bcrypt.hash(password, salt, (err, hash) => {
                                if (err) throw err;
                                let newPass = hash;

                                db.sequelize.query(
                                    `INSERT INTO users (id, firstname, lastname, 
                                        email, phone, dateOfBirth, password,
              ) VALUES 
              ("${maxId}", "${firstname}","${lastname}","${email}","${phone}",
              "${dateOfBirth}","${password}"
               )`)
                                    .then((results) => {
                                        db.sequelize.query(`SELECT * from users where email ="${email}"`)
                                            .then(result => {
                                                //   res.json({
                                                //   status: "success",
                                                //   result : result[]
                                                // });
                                                let user = result[0][0];
                                                console.log(user)

                                                let payload = {
                                                    email: user.email,
                                                }
                                                jwt.sign(payload, "secret", {
                                                    expiresIn: "1d"
                                                },
                                                    (err, token) => {
                                                        if (err) throw err;

                                                        res.json({
                                                            success: true,
                                                            msg: 'Successfully logged in',
                                                            token,
                                                            user
                                                        })
                                                    })
                                            })

                                    })
                                    .catch((err) => {
                                        console.log(err);
                                        res.status(500).json({ status: "failed", err });
                                    })
                            })
                        })
                    }
                })

        })
}


const SignIn = (req, res) => {
    const {   
        email,
        password,
    } = req.body

    db.sequelize.query(`SELECT firstname, lastname, email, phone, dateOfBirth, password from 
		users WHERE email =  "${email}"`)
        .then((result) => {
            // console.log(req.body)
            if (!result[0].length) {
                res.status(400).json({
                    success: false,
                    msg: "user does not exist",

                })
                console.log("user does not exist")
            }
            else {
                console.log(result[0][0].email)

                let originalPassword = result[0][0].password;
                // console.log(password, originalPassword, '====')
                // bcrypt
                //     .compare(password, originalPassword)
                //     .then(isMatch => {
                        // if (isMatch) {
                            if (password === originalPassword) {
                            console.log('matched!')
                            let user = result[0][0];
                            console.log(user)

                            let payload = {
                                email: user.email,
                            }

                            jwt.sign(payload, "secret", {
                                expiresIn: "1d"
                            },
                                (err, token) => {
                                    if (err) throw err;

                                    res.json({
                                        success: true,
                                        msg: 'Successfully logged in',
                                        token,
                                        user
                                    })
                                })
                        } else {
                            return res.status(400).json({ success: false, msg: 'Password not correct' })
                        }
                    // })

                // else{
                // 	res.json({
                // 		response : "Welcome back",
                // 		status : 200,
                // 		username : username,
                // 		result
                // 	})
                // 	console.log("success")
                // }
            }
        })
}



const verifyToken = (req, res) => {
    const authToken = req.headers["authorization"];
    const token = authToken.split(" ")[1]
    console.log(authToken)

    jwt.verify(token, 'secret', (err, decoded) => {
        if (err) {
            return res.json({ success: false, msg: 'Failed to authenticate token', err })
        }

        const { email } = decoded;

        db.sequelize.query(`SELECT *  from users where email="${email}"`)
            .then(result => {
                res.json({ success: true, user: result[0] })
            }).catch((err) => {
                console.log(err);
                res.status(500).json({ status: "failed", err });
            })

    })
}


export {
    SignUp,
    SignIn,
    verifyToken

}