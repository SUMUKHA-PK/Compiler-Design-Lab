int main() {

	int l, m, h;
	int array[5] = {1, 2, 3, 4, 5};
	int key = 2;

	while(l < h) {

		m = (l + h) / 2;

		if(key == array[m])
			return m;

		else if(key < array[m])
			h = m;

		else if(key > array[m])
			l = m + 1;
	}

	return -1;
}

