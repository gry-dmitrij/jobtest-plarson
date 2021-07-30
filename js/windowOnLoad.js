/**
 * Выполняет коллбэк после полной загрузки страницы
 * @param cb - коллбэк функция
 */
function windowOnLoad(cb) {
    function run(cb) {
        if (typeof cb !== 'function') return false;
        if (document.readyState === 'complete') {
            cb();
            return true;
        }
        return false;
    }
    if (!run(cb)){
        document.addEventListener('readystatechange', () => {
            run(cb);
        })
    }
}