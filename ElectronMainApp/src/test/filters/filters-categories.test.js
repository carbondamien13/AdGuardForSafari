const cache = require('../../main/app/filters/cache');
const filtersCategories = require('../../main/app/filters/filters-categories');
const serviceClient = require('../../main/app/filters/service-client');
const filtersMetadata = require('../resources/filtersMetadata.json');

jest.mock('../../utils/app-pack');

jest.spyOn(serviceClient, 'loadRemoteFiltersMetadata').mockImplementation((callback) => {
    callback(filtersMetadata);
});

describe('Filters categories tests', () => {
    it('Categories metadata test', (done) => {
        serviceClient.loadRemoteFiltersMetadata((metadata) => {
            cache.setData(metadata);

            try {
                const data = filtersCategories.getFiltersMetadata();
                expect(data).toBeDefined();
                expect(data).toHaveProperty('categories');
                expect(data.categories).toHaveLength(7);
                expect(data.categories[0]).toHaveProperty('groupId');

                const filters = filtersCategories.getFiltersByGroupId(1);
                expect(filters).toBeDefined();
                expect(filters).toHaveLength(3);
                expect(filters[0]).toHaveProperty('filterId');

                done();
            } catch (error) {
                console.log(error.message);
            }
        });
    });
});
