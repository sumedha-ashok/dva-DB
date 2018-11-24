'use strict';
var Sequelize = require('sequelize');
var models = require('./models');
const uuid = require('uuid/v4');
models.sequelize.sync();



const Review = models.Review;
const ProductCluster = models.ProductCluster;
const Cluster = models.Cluster;
const Aspect = models.Aspect;
const ReviewAspect = models.ReviewAspect;
const Product = models.Product;

async function addCluster(name) {
    // return clusterId
    var cluster = await Cluster.findOrCreate({
        where: {
            name: name
        },
        defaults: {
            name: name
        }
    });
    return cluster[0].id;
}

async function addAspect(noun, adjective, polarity) {
    // return clusterId
    var aspect = await Aspect.findOrCreate({
        where: {
            noun: noun,
            adjective: adjective,
            polarity: polarity
        },
        defaults: {
            noun: noun,
            adjective: adjective,
            polarity: polarity
        }
    });
    return aspect[0].id;
}

async function addReviewAspect(reviewId, aspectId) {
    // return clusterId
    return await ReviewAspect.findOrCreate({
        where: {
            reviewId: reviewId,
            aspectId: aspectId
        },
        defaults: {
            reviewId: reviewId,
            aspectId: aspectId
        }
    })[0].id;
}

async function addProductCluster(productId, clusterId) {
    // return clusterId
    return await ProductCluster.findOrCreate({
        where: {
            productId: productId,
            clusterId: clusterId
        },
        defaults: {
            productId: productId,
            clusterId: clusterId
        }
    })[0].id;
}

async function addReview(reviewId, review, product) {
    //console.log(review);
    var productId = await addProduct(product);
    var review = await Review.findOrCreate({
            where: {
                reviewId: reviewId
            },
            defaults: review
    });
    return review[0].id;
}

async function addProduct(product) {
    //console.log(review);
    var product = await Product.findOrCreate({
        where: {
            productId: product.productId
        },
        defaults: product
    });
    return product[0].id;
}


module.exports = {
    addReview: addReview,
    addProductCluster: addProductCluster,
    addReviewAspect: addReviewAspect,
    addCluster: addCluster,
    addAspect: addAspect
}