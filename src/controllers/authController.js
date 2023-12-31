const { Router } = require('express');
const router = Router();

const User = require('../models/UserModel');
const verifyToken = require('./verifyToken')

const jwt = require('jsonwebtoken');
const config = require('../config');

const placaController = require('./placaController')


router.post('/signup', async(req, res) => {
    try {
        // Receiving Data
        const { username, email, password } = req.body;
        // Creating a new User
        const user = new User({
            username,
            email,
            password
        });
        user.password = await user.encryptPassword(password);
        await user.save();
        // Create a Token
        const token = jwt.sign({ id: user.id }, config.secret, {
            expiresIn: 60 * 60 * 24 // expires in 24 hours
        });

        res.json({ auth: true, token });

    } catch (e) {
        console.log(e)
        res.status(500).send('Ocorreu um problema ao registrar seu usuário');
    }
});

router.route('/placas')
    .get(placaController.index)
    .post(placaController.new)

router.route('/placas/:id')
    .get(placaController.view)
    .put(placaController.update)
    .delete(placaController.delete)


router.post('/signin', async(req, res) => {
    try {
        const user = await User.findOne({ email: req.body.email })
        if (!user) {
            return res.status(404).send("O email não existe")
        }
        const validPassword = await user.validatePassword(req.body.password, user.password);
        if (!validPassword) {
            return res.status(401).send({ auth: false, token: null });
        }
        const token = jwt.sign({ id: user._id }, config.secret, {
            expiresIn: '24h'
        });
        res.status(200).json({ auth: true, token });
    } catch (e) {
        console.log(e)
        res.status(500).send('Erro no login');
    }
});


router.get('/dashboard', (req, res) => {
    res.json('dashboard');
})

router.get('/logout', function(req, res) {
    res.clearCookie(); // Limpa todos os cookies
    res.status(200).send({ auth: false, token: null });
});

module.exports = router;