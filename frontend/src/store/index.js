import { createStore } from 'vuex';

const store = createStore({
    state: {
        flashMessage: {
            message: null,
            type: null,
        },
        isLoggedIn: false,
        userId: null,
         authToken: null,
    },
    mutations: {
        SET_FLASH_MESSAGE(state, { message, type }) {
            state.flashMessage.message = message;
            state.flashMessage.type = type;
        },
        CLEAR_FLASH_MESSAGE(state) {
            state.flashMessage.message = null;
            state.flashMessage.type = null;
        },
        SET_USER_INFO(state, { userId, authToken }) {
            state.isLoggedIn = !!userId;
             state.userId = userId;
             state.authToken = authToken;
         },
        CLEAR_USER_INFO(state) {
            state.isLoggedIn = false;
            state.userId = null;
             state.authToken = null;
        },
    },
    actions: {
        setFlashMessage({ commit }, { message, type }) {
            commit('SET_FLASH_MESSAGE', { message, type });
        },
        clearFlashMessage({ commit }) {
            commit('CLEAR_FLASH_MESSAGE');
        },
        setUserInfo({commit}, {userId, authToken}) {
            commit('SET_USER_INFO', {userId, authToken});
        },
        clearUserInfo({commit}){
            commit('CLEAR_USER_INFO')
        }
    },
});

export default store;