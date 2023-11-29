const Placa = require('../models/PlacaModels');

exports.index = (req, res) => {
    Placa.find((err, placas) => {
        if (err) {
            res.json({
                status: 'error',
                code: 500,
                message: err
            });
        }

        res.json(placas);
    });
}

// Função para criar uma nova placa
exports.new = function(req, res) {
    let placa = new Placa();
    placa.placas = req.body.placas;
    placa.dadosDaPlaca = req.body.dadosDaPlaca;
    placa.renavam = req.body.renavam;
    placa.status = req.body.status;

    placa.save(function(err) {
        if (err) {
            res.json({
                status: 'error',
                code: 500,
                message: err
            });
        }

        res.json({
            status: 'success',
            code: 200,
            message: 'Registro salvo',
            data: placa
        });
    });
}

// Função para visualizar informações de uma placa
exports.view = function(req, res) {
    Placa.findById(req.params.id, function(err, placa) {
        if (err) {
            res.json({
                status: 'error',
                code: 500,
                message: err
            });
        }

        res.json({
            status: 'success',
            code: 200,
            message: 'Registro encontrado',
            data: placa
        });
    });
}

// Função para atualizar informações de uma placa
exports.update = function(req, res) {
    Placa.findById(req.params.id, function(err, placa) {
        if (err) {
            res.json({
                status: 'error',
                code: 500,
                message: err
            });
        }
        placa.placas = req.body.placas;
        placa.dadosDaPlaca = req.body.dadosDaPlaca;
        placa.renavam = req.body.renavam;
        placa.status = req.body.status;

        placa.save(function(err) {
            if (err) {
                res.json({
                    status: 'error',
                    code: 500,
                    message: err
                });
            }

            res.json({
                status: 'success',
                code: 200,
                message: 'Registro atualizado',
                data: placa
            });
        });
    });
}

// Função para excluir uma placa
exports.delete = function(req, res) {
    Placa.remove({
        _id: req.params.id
    }, function(err) {
        if (err) {
            res.json({
                status: 'error',
                code: 500,
                message: err
            });
        }

        res.json({
            status: 'success',
            code: 200,
            message: 'Registro eliminado'
        });
    });
}
