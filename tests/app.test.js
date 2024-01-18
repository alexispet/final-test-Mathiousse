import request from 'supertest'
import app from '../app.js'

describe('GET /post', () => {
    it('responds with json', (done) => {
        request(app)
            .get('/post')
            .set('Accept', 'application/json')
            .expect('Content-Type', /json/)
            .expect(200, done)
    })
})
